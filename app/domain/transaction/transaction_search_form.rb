class TransactionSearchForm < Form

  attribute :accounting_period_id, Integer
  attribute :accounting_period_name, String
  attribute :type, TransactionType
  attribute :template, Boolean
  alias template template?
  attribute :expected, Boolean
  alias expected expected?
  attribute :term
  attribute :sort

  def accounting_period_name=(name)
    super(name)
    self.accounting_period_id = AccountingPeriodRepository.search_id_by_name(name) || raise(UnknownAccountingPeriodError)
  end
end