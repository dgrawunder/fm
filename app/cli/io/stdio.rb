module FmCli
  module Stdio

    include CommandLineReporter
    include CategoryOutput

    def print(*args)
      @output.say *args
    end

    def print_success(message)
      print_blank_line
      print message.colorize(:green)
    end

    def print_failure(message)
      print_blank_line
      print message.colorize(:red)
    end

    def print_form_errors(errors)
      print_blank_line
      errors.full_messages.each do |message|
        print message
      end
      print_blank_line
    end

    def print_blank_line
      print "\n"
    end
  end
end