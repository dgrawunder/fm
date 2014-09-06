module FmCli
  class Cli < FmCli::Command

    include Transaction
    include BalanceCommand

    desc 'period SUBCOMMAND [OPTIONS]', 'Manage accounting periods'
    subcommand "period", FmCli::AccountingPeriod

    desc 'category SUBCOMMAND [OPTIONS]', 'Manage categories'
    subcommand "category", FmCli::Category

    desc 'report SUBCOMMAND [OPTIONS]', 'Show different reports'
    subcommand "report", FmCli::ReportCommand
  end
end