class GetCategoryReport

  def initialize transaction_type_name
    @transaction_type_name = transaction_type_name
  end

  def run

    search_form = CategorySearchForm.new({
                                             transaction_type: transaction_type,
                                             sort: 'name asc'
                                         })

    categories = CategoryRepository.search(search_form)

    category_sums = categories.map do |category|
      CategorySums.new(category, transaction_category_to_id_map[category.id])
    end

    if transaction_category_to_id_map[nil].presence
      category_sums << CategorySums.new(nil, transaction_category_to_id_map[nil])
    end

    category_sums
  end

  private

  def transaction_category_to_id_map
    @transaction_category_to_id_map ||= begin

      transaction_category_to_id_map = {}

      transactions.each do |transaction|
        unless transaction_category_to_id_map[transaction.category_id]
          transaction_category_to_id_map[transaction.category_id] = Array.new
        end
        transaction_category_to_id_map[transaction.category_id] << transaction
      end

      transaction_category_to_id_map
    end

  end

  def transactions
    TransactionRepository.search(
        TransactionSearchForm.new(
            {
                accounting_period_id: current_accounting_period_id,
                type: transaction_type
            }
        ))
  end

  def transaction_type
    @transaction_type ||= begin
      TransactionType.find_number(@transaction_type_name) || raise(UnknownTransactionTypeError)
    end
  end

  def current_accounting_period_id
    PropertyRepository.find_current_accounting_period_id || raise(NoCurrentAccountingPeriodError)
  end

end