class TransactionSearchForm < Form

  attribute :accounting_period_id, Integer
  attribute :type, TransactionType
  attribute :sort

  def accounting_period_name(name)
    self.accounting_period_id = AccountingPeriodRepository.search_id_by_name(accounting_period_name)
  end
end