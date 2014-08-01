class TransactionSearchForm < Form

  attribute :accounting_period_id, Integer
  attribute :type, TransactionType
  attribute :sort

end