module FmCli
  module BalanceCommand
    def self.included(base)
      base.class_eval do

        desc 'balance OPTIONS', 'Shows accounting period balance report'
        def balance
          run_interaction(:get_balance_report)
        end
      end
    end
  end
end