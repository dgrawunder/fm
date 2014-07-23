module FmCli
  class Interaction

    def initialize(io)
      @io = io
    end

    def run(*args)
      raise NotImplementedError
    end

    private

    attr_reader :io
  end
end