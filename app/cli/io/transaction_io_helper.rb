module FmCli
  module TransactionIoHelper

    def print_transaction(transaction)
      table do
        row do
          column('ID', :width => 20)
          column(transaction.id, :width => 40)
        end
        row do
          column('A. PERIOD')
          column(transaction.accounting_period.try(:name))
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
        row do
          column('DATE')
          column(format_date transaction.date)
        end
        row do
          column('TYPE')
          column(TransactionType.find_name(transaction.type).to_s.capitalize)
        end
      end
    end

    def print_transactions(transactions)
      # table(:border => false) do
      #   row do
      #     column('ID', :width => 6, :align => 'right')
      #     column('NAME', :width => 20)
      #   end
      #   transactions.each do |transaction|
      #     row do
      #       column(transaction.id)
      #       column(transaction.name)
      #     end
      #   end
      # end
    end
  end
end




