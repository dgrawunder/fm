class SetCurrentAccountingPeriod

  def initialize id
    @id = id
  end

  def run
    accounting_period = AccountingPeriodRepository.find(@id)
    PropertyRepository.save_value(Property::CURRENT_ACCOUNTING_PERIOD_ID, accounting_period.id)
  end
end