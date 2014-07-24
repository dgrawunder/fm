class CategoryForm < Form

  attribute :name, String
  attribute :transaction_type, TransactionType, default: TransactionType[:expense]

  validates :name, presence: true, length: {maximum: 32}
  validates :transaction_type, inclusion: TransactionType.numbers, allow_nil: false
  validate do
    uniquness_constraint = {name: name, transaction_type: transaction_type}
    uniquness_constraint[:id] = entity_id if on_update?
    if CategoryRepository.exists?(uniquness_constraint)
      errors.add :name, I18n.t('errors.messages.taken')
    end
    if on_update? && TransactionRepository.exists?(category_id: entity_id)
      errors.add :transaction_type, 'could not be updated when associated transactions exists.'
    end
  end
end