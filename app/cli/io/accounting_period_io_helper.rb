module FmCli
  module AccountingPeriodIoHelper

    def print_accounting_period(accounting_period)
      table do
        row do
          column('ID', :width => 20)
          column(accounting_period.id, :width => 40)
        end
        row do
          column('NAME')
          column(accounting_period.name)
        end
        row do
          column('STARTS AT')
          column(format_date accounting_period.starts_at)
        end
        row do
          column('ENDS AT')
          column(format_date accounting_period.ends_at)
        end
        row do
          column('INITIAL DEPOSIT')
          column(format_currency accounting_period.initial_deposit)
        end
      end
    end

    def print_accounting_periods(accounting_periods)
      table(:border => false) do
        row do
          column('ID', :width => 6, :align => 'right')
          column('NAME', :width => 25)
          column('STARTS AT', :width => 15)
          column('ENDS AT', :width => 15)
          column('INITIAL DEPOSIT', :width => 15, :align => 'right')
        end
        accounting_periods.each do |accounting_period|
          row do
            column(accounting_period.id)
            column(accounting_period.name)
            column(format_date accounting_period.starts_at)
            column(format_date accounting_period.ends_at)
            column(format_currency accounting_period.initial_deposit)
          end
        end
      end
    end
  end
end




