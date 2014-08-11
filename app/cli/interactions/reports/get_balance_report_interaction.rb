module FmCli
  class GetBalanceReportInteraction < Interaction

    def run
      balance_report = GetBalanceReport.new.run
      io.print_balance_report balance_report
    end
  end
end