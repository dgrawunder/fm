module FmCli
  module TransactionIoHelper

    def print_transaction(transaction)
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
          column(format_currency transaction.amount)
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
          column(TransactionType.find_name(transaction.type).to_s.capitalize)
        end
      end
    end

    def print_transactions(transactions, template)
      table(:border => false) do
        row do
          column('ID', width: 8, color: table_header_fg_color)
          column('CATEGORY', width: 25, color: table_header_fg_color)
          column('DESCRIPTION', width: 30, color: table_header_fg_color)
          column('AMOUNT', color: table_header_fg_color)
          if template
            column('DOM', width: 3, align: 'right', color: table_header_fg_color)
          else
            column('DATE', color: table_header_fg_color)
          end
        end
        transactions.each do |transaction|
          row do
            column(transaction.id, color: table_body_fg_color)
            column(transaction.category.try(:name), color: table_body_fg_color)
            column(transaction.description, color: table_body_fg_color)
            column(format_currency(transaction.amount), color: table_body_fg_color)
            if template
              column(transaction.day_of_month, color: table_body_fg_color)
            else
              column(format_date(transaction.date), color: table_body_fg_color)
            end
          end
        end
      end
    end
  end
end




