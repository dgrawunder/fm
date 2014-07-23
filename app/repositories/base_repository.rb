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
      record_class.delete(id) == 1
    end

    def find(id)
      build_entity record_class.find(id)
    end

    def exists?(id)
      record_class.where(id: id).exists?
    end

    def first
      record_class.first
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

    private

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
      scope.map { |record| build_entity(record, included_associations) }
    end

    def entity_class
      @entity_class ||= "#{self.name}".gsub('Repository', '').constantize
    end

    def record_class
      @record_class ||= "ActiveRecordMapper::#{self.name}".gsub('Repository', '').constantize
    end
  end
end