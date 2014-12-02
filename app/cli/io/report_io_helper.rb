module FmCli
  module ReportIoHelper

    def print_balance_report balance_report
      table do
        row do
          column('CREDIT', width: 15)
          column(format_currency(balance_report.credit), width: 12, align: 'right')
          column(format_currency(balance_report.total_expected_credit), width: 12, align: 'right', color: 'cyan')
        end
        row do
          column('CREDIT w. Rec.')
          column(format_currency(balance_report.credit_including_receivables))
          column(format_currency(balance_report.total_expected_credit_including_receivables))
        end
      end
      print(('_'*41).green)
      table do
        row do
          column('BALANCE', width: 15)
          column(format_currency(balance_report.balance), width: 12, align: 'right')
          column(format_currency(balance_report.total_expected_balance), width: 12, align: 'right', color: 'cyan')
        end
      end
      print(('_'*41).blue)
      table do
        row do
          column('EXPENSES', width: 15)
          column(format_currency(balance_report.expenses), width: 12, align: 'right')
          column(format_currency(balance_report.total_expected_expenses), width: 12, align: 'right', color: 'cyan')
        end
        row do
          column('INCOMES')
          column(format_currency(balance_report.incomes))
          column(format_currency(balance_report.total_expected_incomes))
        end
        row do
          column('INPAYMENTS')
          column(format_currency(balance_report.inpayments))
          column(format_currency(balance_report.total_expected_inpayments))
        end
        row do
          column('OUTPAYMENTS')
          column(format_currency(balance_report.outpayments))
          column(format_currency(balance_report.total_expected_outpayments))
        end
        row do
          column('RECEIVABLES')
          column(format_currency(balance_report.receivables))
          column(format_currency(balance_report.total_expected_receivables))
        end
      end
    end

    def print_category_report category_report
      table do
        category_report.each do |category_sums|
          row do
            column(category_sums.category.try(:name) || 'Without Category', width: 20)
            column(format_currency(category_sums.actual_sum), width: 12, align: 'right')
            column(format_currency(category_sums.total_expected_sum), width: 12, align: 'right', color: 'cyan')
          end
        end
      end
    end
  end
end
