module FmCli
  class ShowCurrentAccountingPeriodInteraction < FmCli::Interaction

    def run
      begin
        io.print_accounting_period FindCurrentAccountingPeriod.new.run
      rescue RecordNotFoundError
        io.print_failure "Current accounting period not exists"
      end
    end
  end
end