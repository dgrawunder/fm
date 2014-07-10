class TransactionForm < Form

  attribute :category_id, Integer
  attribute :description, String
  attribute :date, Date
  attribute :expected, Boolean, default: false
  attribute :type, TransactionType, default: TransactionType[:expense]

  validates :description, presence: true, length: {maximum: 48}
  validates :category_id, presence: true
  validate do |form|
    if form.category_id.present? && !CategoryRepository.exists_by_name_name_and_transaction_type?(category_id, type)
      errors.add :category_id, "doesn't exists"
    end
  end

  def category_id=(value)
    value.is_a?(Integer) ? super : super(CategoryRepository.id_by_name_and_transaction_type(value, type))
  end

  def date=(value)
    value.is_a?(Date) ? super : super(DateParser.parse(value))
  end
end