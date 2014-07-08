class Form
  include Virtus.model
  include ActiveModel::Validations

  def validate!
    raise ValidationError, errors if !valid?
  end
end