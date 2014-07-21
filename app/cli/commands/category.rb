module FmCli
  class Category < Thor
    include CommandLineReporter

    desc 'add <name> [...OPTIONS]', 'Adds a category'
    method_option 'transaction-type', aliases: '-t', default: 'expense'

    def add(name)
      # form = CategoryForm.new(
      #     name: name,
      #     transaction_type: options['transaction-type']
      # )
      # category = CreateCategory.new(form).run

      # include CommandLineReporter

      table do
        row do
          column('NAME', :width => 20)
          column('ADDRESS', :width => 30, :align => 'left', :padding => 5)
          column('CITY', :width => 15)
        end
        row do
          column('Caesar')
          column('1 Appian Way')
          column('Rome')
        end
        row do
          column('Richard Feynman')
          column('1 Golden Gate')
          column('Quantum Field')
        end
      end
    end

    # def update
    # end

    desc 'delete <id> [...OPTIONS]', 'Deletes a Category forevermore'

    def delete
      # category =
    end

  end
end