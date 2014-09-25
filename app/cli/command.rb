module FmCli
  class Command < Thor

    private

    def io
      @io ||= Stdio.new(self, self)
    end

    def run_interaction name, *args
      interaction_class_name = 'FmCli::' + name.to_s.split('_').collect! { |part| part.capitalize }.join + 'Interaction'
      interaction_class_name.constantize.new(io).run(*args)
    end
  end
end
