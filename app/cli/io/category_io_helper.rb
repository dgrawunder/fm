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
          column('ID', width: 8, color: table_header_fg_color)
          column('NAME', width: 20, color: table_header_fg_color)
        end
        categories.each do |category|
          row do
            column(category.id, color: table_body_fg_color)
            column(category.name, color: table_body_fg_color)
          end
        end
      end
    end
  end
end




