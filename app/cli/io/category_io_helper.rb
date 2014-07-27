module FmCli
  module CategoryIoHelper

    def print_category(category)
      table do
        row do
          column('ID', :width => 20)
          column(category.id, :width => 40)
        end
        row do
          column('NAME')
          column(category.name)
        end
        row do
          column('TRANSACTION-TYPE')
          column(TransactionType.find_name(category.transaction_type).to_s.capitalize)
        end
      end
    end

    def print_categories(categories)
      table(:border => false) do
        row do
          column('ID', :width => 6, :align => 'right')
          column('NAME', :width => 20)
        end
        categories.each do |category|
          row do
            column(category.id)
            column(category.name)
          end
        end
      end
    end
  end
end




