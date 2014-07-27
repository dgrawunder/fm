module FmCli
  class AccountingPeriod < FmCli::Command

    desc 'add <name> [...OPTIONS]', 'Adds a accounting_period'
    method_option '--starts-at', aliases: '-s'
    method_option '--ends-at', aliases: '-e'
    method_option '--initial-deposit', aliases: '-d'

    def add(name)
      form = AccountingPeriodForm.new(
          name: name
      )
      form.starts_at = options['starts-at'] if options['starts-at']
      form.ends_at = options['ends-at'] if options['ends-at']
      form.initial_deposit = options['initial-deposit'] if options['initial-deposit']

      run_interaction(:create_entity, form, :accounting_period)
    end

  end
end
