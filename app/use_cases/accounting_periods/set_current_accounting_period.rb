class SetCurrentAccountingPeriod

  def initialize identifier
    @identifier = identifier
  end

  def run
    id = AccountingPeriodIdentifierResolver.resolve_to_id(@identifier)
    accounting_period = AccountingPeriodRepository.find(id)
    PropertyRepository.save_value(Property::CURRENT_ACCOUNTING_PERIOD_ID, accounting_period.id)
    accounting_period
  end
end