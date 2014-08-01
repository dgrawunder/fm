class EntityForm < Form
  include ActiveModel::Validations

  attr_accessor :entity_id

  def on_new?
    entity_id.nil?
  end

  def on_update?
    entity_id.present?
  end

  def validate!
    raise ValidationError, errors if !valid?
  end
end