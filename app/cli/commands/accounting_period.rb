module FmCli
  class AccountingPeriod < FmCli::Command

    def self.common_create_and_update_options
      method_option '--starts-at', aliases: '-s'
      method_option '--ends-at', aliases: '-e'
      method_option '--initial-deposit', aliases: '-d'
    end

    desc 'add <name> [...OPTIONS]', 'Adds an accounting period'
    common_create_and_update_options

    def add(name)
      attributes = {name: name}
      fill_attributes_with_common_create_and_update_options(attributes, options)

      run_interaction(:create_entity, attributes, :accounting_period)
    end

    desc 'list', 'Lists all accounting periods'

    def list
      run_interaction(:list_accounting_periods)
    end

    desc 'update <id> [...OPTIONS]', 'Adds an accounting period'
    method_option '--name', aliases: '-n'
    common_create_and_update_options

    def update(id)
      attributes = {}
      attributes[:name] = options[:name] if options[:name]
      fill_attributes_with_common_create_and_update_options(attributes, options)

      run_interaction(:update_entity, id, attributes, :accounting_period)
    end

    desc 'delete <id>', 'Deletes a accounting period forevermore'

    def delete(id)
      run_interaction(:delete_entity, id, :accounting_period)
    end

    desc 'current [OPTIONS]', 'Shows or change current accounting period'
    method_option '--accounting-period', aliases: '-p'

    def current
      if options['accounting-period']
        run_interaction(:set_current_accounting_period, options['accounting-period'])
      else
        run_interaction(:show_current_accounting_period)
      end
    end

    private

    def fill_attributes_with_common_create_and_update_options(attributes, options)
      attributes[:starts_at] = options['starts-at'] if options['starts-at']
      attributes[:ends_at] = options['ends-at'] if options['ends-at']
      attributes[:initial_deposit] = options['initial-deposit'] if options['initial-deposit']
    end

  end
end
