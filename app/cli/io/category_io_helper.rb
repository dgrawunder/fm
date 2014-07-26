module FmCli
  module CategoryIoHelper

    def print_category(category)
      print_blank_line
      table do
        row do
          column('NAME', :width => 20)
          column(category.name, :width => 40)
        end
        row do
          column('TRANSACTION-TYPE')
          column(TransactionType.find_name(category.transaction_type).to_s.capitalize)
        end
      end
      print_blank_line
    end

    def print_categories(categories)
      print_blank_line
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
      print_blank_line
    end
  end
end




