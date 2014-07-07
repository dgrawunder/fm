class CategoryForm
  include Virtus.model
  include ActiveModel::Validations

  attribute :name, String
  attribute :transaction_type, TransactionType, default: TransactionType[:expense]

  validates :name, presence: true, length: {maximum: 32}
  validates :transaction_type, inclusion: TransactionType.numbers, allow_nil: false

  def validate!
    raise ValidationError, errors if !valid?
  end
end