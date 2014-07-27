module FmCli
  class ListCategoriesInteraction < Interaction

    def run(transaction_type_name)
      begin
        categories = ShowAllCategories.new(transaction_type_name).run
        io.print_categories(categories)
      rescue UnknownTransactionTypeError
        io.print_failure "Invalid transaction type '#{transaction_type_name}'"
      end
    end
  end
end