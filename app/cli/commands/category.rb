module FmCli
  class Category < FmCli::Command
    include CommandLineReporter

    desc 'add <name> [...OPTIONS]', 'Adds a category'
    method_option 'transaction-type', aliases: '-t', default: 'expense'

    def add(name)
      form = CategoryForm.new(
          name: name,
          transaction_type: options['transaction-type']
      )

      run_interaction(:create_entity, form, :category)
    end


    desc 'update <id> [...OPTIONS]', 'Adds a category'
    method_option 'name', aliases: '-n'
    method_option 'transaction-type', aliases: '-t'

    def update(id)
      attributes = {}
      attributes[:name] = options[:name] if options[:name]
      attributes[:transaction_type] = options['transaction-type'] if options['transaction-type']

      run_interaction(:update_entity, id, attributes, :category)
    end

    desc 'delete <id>', 'Deletes a Category forevermore'

    def delete(id)
      run_interaction(:delete_entity, id, :category)
    end

  end
end
