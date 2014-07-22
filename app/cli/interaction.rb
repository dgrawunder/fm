module FmCli
  class Interaction

    include Stdio

    def initialize(output, input)
      @output, @input = output, input
    end

    def run(*args)
      raise NotImplementedError
    end

  end
end