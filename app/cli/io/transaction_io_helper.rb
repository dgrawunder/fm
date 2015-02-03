module FmCli
  module TransactionIoHelper

    def print_transaction(transaction)
      print 'FIXED '.yellow if transaction.fixed?
      print 'TEMPLATE'.yellow if transaction.template?
      print "#{'REPAID '.yellow if transaction.repaid?}#{'RECEIVABLE'.yellow if transaction.receivable?}"
      table do
        row do
          column('ID', :width => 20)
          column(transaction.id, :width => 40)
        end
        unless transaction.template?
          row do
            column('ACCOUNTING PERIOD')
            column(transaction.accounting_period.try(:name))
          end
        end
        row do
          column('CATEGORY')
          column(transaction.category.try(:name))
        end
        row do
          column('DESCRIPTION')
          column(transaction.description)
        end
        row do
          column('AMOUNT')
          column(format_currency transaction.amount, expected: transaction.expected)
        end
        if transaction.template?
          row do
            column('DAY OF MONTH')
            column(transaction.day_of_month)
          end
        else
          row do
            column('DATE')
            column(format_date transaction.date)
          end
        end
        row do
          column('TYPE')
          column(TransactionType.find_name(transaction.type).to_s.capitalize,
                 color: transaction_type_color(transaction.type))
        end
      end
    end

    def print_transactions(transactions, template: false, display_type: false)
      table(:border => false) do
        row do
          column('ID', width: 8, color: table_header_fg_color)
          column('CATEGORY', width: 20, color: table_header_fg_color)
          column('DESCRIPTION', width: 35, color: table_header_fg_color)
          column('AMOUNT', align: 'right', color: table_header_fg_color)
          if template
            column('DOM', width: 3, align: 'right', color: table_header_fg_color)
          else
            column('DATE', width: 12, align: 'right', color: table_header_fg_color)
          end
          if display_type
            column('', width: 3, color: table_header_fg_color)
          end
          column('', width: 4)
        end
        transactions.each do |transaction|
          row do
            column(transaction.id, color: table_body_fg_color)
            column(transaction.category.try(:name), color: table_body_fg_color)
            column(transaction.description, color: table_body_fg_color)
            column(format_currency(transaction.amount), color: transaction.expected ? expected_color : table_body_fg_color)
            if template
              column(transaction.day_of_month, color: table_body_fg_color)
            else
              column(format_date(transaction.date), color: table_body_fg_color)
            end
            if display_type
              column(TransactionType.find_name(transaction.type)[0..2].capitalize,
                     color: transaction_type_color(transaction.type))
            end
            column("#{transaction.fixed? ? 'F' : ''}#{transaction.receivable? ? 'Rec' : ''}", color: :yellow)
          end
        end
      end
    end

    def transaction_type_color(type)
      if type == TransactionType[:expense]
        :red
      elsif type == TransactionType[:income]
        :green
      else
        :yellow
      end
    end
  end
end