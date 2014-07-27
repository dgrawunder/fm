module FmCli
  class ListAccountingPeriodsInteraction < FmCli::Interaction

    def run
      accounting_periods = FindAllAccountingPeriods.new.run
      io.print_accounting_periods(accounting_periods)
    end
  end
end