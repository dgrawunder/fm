module BaseRepository

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def create(entity)
      record = record_class.new
      copy_attributes_to_record(record, entity)
      if record.save
        entity.id = record.id
        entity
      else
        false
      end
    end

    def update(entity)
      record = record_class.find(entity.id)
      copy_attributes_to_record(record, entity)
      record.save
    end

    def count
      record_class.count
    end

    def delete id
      record_class.destroy(id) == 1
    end

    def find(id)
      begin
        build_entity record_class.find(id)
      rescue
        raise RecordNotFoundError, "Couldn't find #{entity_class.name} with 'id'=#{id}"
      end
    end

    def exists?(constraint={})
      if constraint.blank?
        record_class.exits?
      elsif constraint.is_a?(Hash)
        record_class.where(constraint).exists?
      else
        record_class.exists?(constraint)
      end
    end

    def first
      build_entity record_class.first
    end

    def all
      build_entities record_class.all
    end

    def build_entity record, included_associations=[]
      return if record.nil?
      entity = entity_class.new
      entity.id = record.id
      copy_attributes_to_entity(entity, record, included_associations)
      included_associations.each do |association|
        # TODO cleanup
        repository = "#{association.to_s.capitalize}Repository".constantize
        entity.public_send("#{association}=", repository.build_entity(record.send(association)))
      end
      entity
    end

    def unique?(id, scope)
      query = record_class.where(scope)
      if id.present?
        query = query.where.not(id: id)
      end
      !query.exists?
    end

    private

    def build_entities records, included_associations=[]
      records.map do |record|
        build_entity record, included_associations
      end
    end

    def copy_attributes_to_record(record, entity)
      record.attributes = Hash[
          record_class.mapped_attributes.map do |attribute|
            [attribute, entity.public_send(attribute)]
          end
      ]
    end

    def copy_attributes_to_entity(entity, record, included_associations=[])
      entity.id = record.id
      record.class.mapped_attributes.each do |attribute|
        entity.public_send("#{attribute}=", record.public_send(attribute))
      end
    end

    def run_query scope, included_associations=[]
      build_entities(scope.to_a, included_associations)
    end

    def entity_class
      @entity_class ||= "#{self.name}".gsub('Repository', '').constantize
    end

    def record_class
      @record_class ||= "ActiveRecordMapper::#{self.name}".gsub('Repository', '').constantize
    end
  end
end