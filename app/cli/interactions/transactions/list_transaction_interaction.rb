module FmCli
  class ListTransactionInteraction < Interaction

    def run(attributes)
      if attributes[:accounting_period_name].present?
        use_case_class = SearchTransactions
      else
        use_case_class = SearchCurrentTransactions
      end
      form = TransactionSearchForm.new(attributes)
      transactions = use_case_class.new(form).run
      io.print_transactions(transactions)
    end
  end
end