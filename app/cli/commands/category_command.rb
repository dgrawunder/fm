module FmCli
  class Category < FmCli::Command

    desc 'category add NAME [OPTIONS]', 'Add a category'
    method_option 'transaction-type', aliases: '-t', default: 'expense'

    def add(name)
      attributes = {
          name: name,
          transaction_type: options['transaction-type']
      }

      run_interaction(:create_entity, attributes, :category)
    end

    desc 'category list [OPTIONS]', 'List all categories of given transaction type'
    method_option 'transaction-type', aliases: '-t', default: 'expense'

    def list
      run_interaction(:list_categories, options['transaction-type'])
    end


    desc 'category update ID [OPTIONS]', 'Update a category'
    method_option 'name', aliases: '-n'
    method_option 'transaction-type', aliases: '-t'

    def update(id)
      attributes = {}
      attributes[:name] = options[:name] if options[:name]
      attributes[:transaction_type] = options['transaction-type'] if options['transaction-type']

      run_interaction(:update_entity, id, attributes, :category)
    end

    desc 'category delete ID', 'Delete a category forevermore'

    def delete(id)
      run_interaction(:delete_entity, id, :category)
    end

  end
end
