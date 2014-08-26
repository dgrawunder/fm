module FmCli
  class SearchTransactionInteraction < FmCli::Interaction

    def run(attributes)
      search_form = TransactionSearchForm.new(attributes.merge(templatte: false))
      transactions = SearchTransactions.new(search_form, only_currents: true).run
      io.print_transactions(transactions, false)
    end
  end
end