module FmCli
  class SetCurrentAccountingPeriodInteraction < FmCli::Interaction

    def run identifier
      begin
        accounting_period = ::SetCurrentAccountingPeriod.new(identifier).run
        io.print_success "Successfully changed current accounting period"
        io.print_blank_line
        io.print_accounting_period accounting_period
      rescue RecordNotFoundError
        io.print_failure "Couldn't find specified accounting period"
      end
    end
  end
end
