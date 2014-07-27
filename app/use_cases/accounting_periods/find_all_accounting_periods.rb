class FindAllAccountingPeriods

  def run
    AccountingPeriodRepository.all_ordered_by_starts_at_desc
  end
end