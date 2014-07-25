class CategoryForm < Form

  attribute :name, String
  attribute :transaction_type, TransactionType, default: TransactionType[:expense]

  validates :name, presence: true, length: {maximum: 32}
  validates :transaction_type, inclusion: TransactionType.numbers, allow_nil: false
  validate do
    unless CategoryRepository.unique?(entity_id, {name: name, transaction_type: transaction_type})
      errors.add :name, I18n.t('errors.messages.taken')
    end
    if on_update? && TransactionRepository.exists?(category_id: entity_id)
      errors.add :transaction_type, 'could not be updated when associated transactions exists.'
    end
  end
end