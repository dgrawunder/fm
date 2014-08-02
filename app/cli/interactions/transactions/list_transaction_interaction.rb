module FmCli
  class ListTransactionInteraction < Interaction

    def run(attributes)
      form = TransactionSearchForm.new(attributes)
      if form.template? || form.accounting_period_name.present?
        use_case_class = SearchTransactions
      else
        use_case_class = SearchCurrentTransactions
      end
      transactions = use_case_class.new(form).run
      io.print_transactions(transactions)
    end
  end
end