module FmCli
  class ListTransactionInteraction < Interaction

    def run(attributes)
      accounting_period_name = attributes[:accounting_period_name]
      begin
        form = TransactionSearchForm.new(attributes)
        only_currents = !(form.template? || form.accounting_period_name.present?)
        transactions = SearchTransactions.new(
            form, only_currents: only_currents).run
        io.print_transactions(transactions, template: attributes[:template])
      rescue UnknownAccountingPeriodError
        io.print_failure "Couldn't find accounting period containing #{accounting_period_name}'"
      end
    end
  end
end