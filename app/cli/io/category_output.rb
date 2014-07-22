module FmCli
  module CategoryOutput

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
  end
end



