module FmCli
  class Cli < Thor

    desc 'category SUBCOMMAND ...ARGS', 'Manage categories'
    subcommand "category", FmCli::Category
  end
end