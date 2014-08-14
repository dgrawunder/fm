class GetCategoryReport

  def initialize transaction_type_name
    @transaction_type_name = transaction_type_name
  end

  def run

    transaction_type = TransactionType.find_number(@transaction_type_name)
    raise UnknownTransactionTypeError if transaction_type.nil?

    current_accounting_period_id = PropertyRepository.find_current_accounting_period_id
    raise NoCurrentAccountingPeriodError if current_accounting_period_id.nil?


    search_form = CategorySearchForm.new({
                                             accounting_period_id: current_accounting_period_id,
                                             transaction_type: transaction_type,
                                             sort: 'name asc'
                                         })

    categories = CategoryRepository.search(search)

  end

end