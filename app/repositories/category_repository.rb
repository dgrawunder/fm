class CategoryRepository

  def self.create(entity)
    record = ActiveRecordMapper::Category.new
    copy_attributes_to_record(record, entity)
    if record.save
      entity.id = record.id
      entity
    else
      false
    end
  end

  def self.update(entity)
    record = ActiveRecordMapper::Category.find(entity.id)
    copy_attributes_to_record(record, entity)
    record.save
  end

  def self.count
    ActiveRecordMapper::Category.count
  end

  def self.find(id)
    record = ActiveRecordMapper::Category.find(id)
    entity = Category.new
    entity.id = id
    copy_attributes_to_entity(entity, record)
    entity
  end

  def self.exists_by_name_and_transaction_type?(name, transaction_type)
    ActiveRecordMapper::Category.where(name: name, transaction_type: transaction_type).exists?
  end

  def self.copy_attributes_to_record(record, entity)
    record.attributes = Hash[
        ActiveRecordMapper::Category.mapped_attributes.map do |attribute|
          [attribute, entity.public_send(attribute)]
        end
    ]
  end

  def self.copy_attributes_to_entity(entity, record)
    record.class.mapped_attributes.each do |attribute|
      entity.public_send("#{attribute}=", record.public_send(attribute))
    end
  end
end