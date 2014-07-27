module FmCli
  class Cli < Thor

    desc 'aperiod SUBCOMMAND ...ARGS', 'Manage accounting periods'
    subcommand "aperiod", FmCli::AccountingPeriod

    desc 'category SUBCOMMAND ...ARGS', 'Manage categories'
    subcommand "category", FmCli::Category
  end
end