module FmCli
  class GetCategoryReportInteraction < FmCli::Interaction

    def run transaction_type_name
      begin
        category_report = GetCategoryReport.new(transaction_type_name).run
        io.print_category_report(category_report)
      rescue UnknownTransactionTypeError
        io.print_failure "Invalid transaction type '#{transaction_type_name}'"
      rescue NoCurrentAccountingPeriodError
        io.print_failure "No current accounting period exists'"
      end
    end
  end
end