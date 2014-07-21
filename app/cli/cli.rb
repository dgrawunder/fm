module FmCli
  class Cli < Thor

    desc 'category OPTION', ''
    def category
      puts 'category'
    end

    desc 'category SUBCOMMAND ...ARGS', 'Manage categories'
    subcommand "category", FmCli::Category
  end
end