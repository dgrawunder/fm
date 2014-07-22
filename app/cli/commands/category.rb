module FmCli
  class Category < Thor
    include CommandLineReporter

    desc 'add <name> [...OPTIONS]', 'Adds a category'
    method_option 'transaction-type', aliases: '-t', default: 'expense'

    def add(name)
      form = CategoryForm.new(
          name: name,
          transaction_type: options['transaction-type']
      )

      CreateEntityInteraction.new(self, self).run(form, :category)
    end

    # def update
    # end

    desc 'delete <id> [...OPTIONS]', 'Deletes a Category forevermore'

    def delete
      # category =
    end

  end
end