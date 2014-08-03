class FindCurrentAccountingPeriod

  def run
    id = PropertyRepository.find_current_accounting_period_id
    AccountingPeriodRepository.find(id)
  end
end