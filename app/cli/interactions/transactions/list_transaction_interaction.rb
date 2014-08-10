module FmCli
  class ListTransactionInteraction < Interaction

    def run(attributes)
      form = TransactionSearchForm.new(attributes)
      only_currents = !(form.template? || form.accounting_period_name.present?)
      transactions = SearchTransactions.new(
          form, only_currents: only_currents).run
      io.print_transactions(transactions)
    end
  end
end