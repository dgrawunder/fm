module FmCli
  class ReportCommand < FmCli::Command

    desc 'category [OPTIONS]', 'Show categories sums'
    method_option 'transaction-type', aliases: '-t', default: 'expense'

    def category
      run_interaction(:get_category_report, options['transaction-type'])
    end
  end
end
