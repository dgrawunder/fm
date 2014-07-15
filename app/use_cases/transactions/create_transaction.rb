class CreateTransaction < CreateEntity

  before_validation do |form|
    unless form.template? || form.type == TransactionType[:receivable]
        form.accounting_period_id = PropertyRepository.find_value(Property::CURRENT_ACCOUNTING_PERIOD_ID)
    end
    form.resolve_category_id!
  end
end