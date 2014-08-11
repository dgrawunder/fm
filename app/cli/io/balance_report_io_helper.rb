module FmCli
  module BalanceReportIoHelper

    def print_balance_report balance_report
      table do
        row do
          column('BALANCE', :width => 20)
          column(format_currency(balance_report.balance), :width => 20)
          column(format_currency(balance_report.total_expected_balance), :width => 20)
        end
      end
    end
  end
end
