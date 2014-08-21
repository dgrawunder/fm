module FmCli
  module BalanceCommand
    def self.included(base)
      base.class_eval do

        desc 'balance', 'Shows balance report of current accounting period'
        def balance
          run_interaction(:get_balance_report)
        end
      end
    end
  end
end