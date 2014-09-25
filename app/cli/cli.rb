module FmCli
  class Cli < FmCli::Command

    include Transaction
    include BalanceCommand

    desc 'period SUBCOMMAND [OPTIONS]', 'Manage accounting periods'
    subcommand "period", FmCli::Period

    desc 'category SUBCOMMAND [OPTIONS]', 'Manage categories'
    subcommand "category", FmCli::Category

    desc 'report SUBCOMMAND [OPTIONS]', 'Show different reports'
    subcommand "report", FmCli::ReportCommand

    desc 'version', 'Prints version info'
    def version
      require './config/version'
      io.print("FM Version #{::Fm.version}")
    end
  end
end