module FmCli
  class Cli < FmCli::Command

    include Transaction
    include BalanceCommand

    desc 'aperiod SUBCOMMAND ...ARGS', 'Manage accounting periods'
    subcommand "aperiod", FmCli::AccountingPeriod

    desc 'category SUBCOMMAND ...ARGS', 'Manage categories'
    subcommand "category", FmCli::Category
  end
end