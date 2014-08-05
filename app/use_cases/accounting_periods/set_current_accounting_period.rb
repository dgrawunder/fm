class SetCurrentAccountingPeriod

  def initialize identifier
    @identifier = identifier
  end

  def run
    if @identifier.to_s == @identifier.to_i.to_s
      id = @identifier
    else
      id = AccountingPeriodRepository.search_id_by_name(@identifier)
    end
    accounting_period = AccountingPeriodRepository.find(id)
    PropertyRepository.save_value(Property::CURRENT_ACCOUNTING_PERIOD_ID, accounting_period.id)
    accounting_period
  end
end