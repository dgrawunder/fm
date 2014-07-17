class ShowAllCurrentTransactions

  def initialize type_name
    @type_name = type_name
  end

  def run!
    type = TransactionType.find_number(@type_name)
    raise UnknownTransactionTypeError if type.nil? && @type_name.present?

    criteria = TransactionSearchForm.new(
        type: type,
        sort: 'date desc'
    )

    unless type == TransactionType[:receivable]
      criteria.accounting_period_id = PropertyRepository.find_current_accounting_period_id
    end

    TransactionRepository.search(criteria, include: :category)
  end
end