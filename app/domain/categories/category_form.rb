class CategoryForm < Form

  attribute :name, String
  attribute :transaction_type, TransactionType, default: TransactionType[:expense]

  validates :name, presence: true, length: {maximum: 32}
  validates :transaction_type, inclusion: TransactionType.numbers, allow_nil: false
  validate do |form|
    if CategoryRepository.exists_by_name_and_transaction_type?(form.name, form.transaction_type)
      errors.add :name, I18n.t('errors.messages.taken')
    end
  end
end