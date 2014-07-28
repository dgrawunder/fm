module FmCli
  class Stdio

    def initialize input, output
      @input, @output = input, output
    end

    include CommandLineReporter
    include AccountingPeriodIoHelper
    include CategoryIoHelper
    include FormatHelpers

    def print(*args)
      @output.say *args
    end

    def answered_yes?(question)
      @output.yes? question.colorize(:yellow) + ' (yes|No)'
    end

    def print_success(message)
      print message.colorize(:green)
    end

    def print_failure(message)
      print message.colorize(:red)
    end

    def print_errors(errors)
      errors.full_messages.each do |message|
        print message
      end
    end

    def print_blank_line
      print "\n"
    end
  end
end