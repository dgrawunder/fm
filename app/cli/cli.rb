module FmCli
  class Cli < FmCli::Command

    include Transaction
    include BalanceCommand

    desc 'period SUBCOMMAND ...ARGS', 'Manage accounting periods'
    subcommand "period", FmCli::AccountingPeriod

    desc 'category SUBCOMMAND ...ARGS', 'Manage categories'
    subcommand "category", FmCli::Category

    desc 'report SUBCOMMAND ...ARGS', 'Shows different reports'
    subcommand "report", FmCli::ReportCommand
  end
end