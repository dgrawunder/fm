module FmCli
  class Command < Thor

    private

    def run_interaction name, *args
      io = Stdio.new(self, self)
      interaction_class_name = 'FmCli::' + name.to_s.split('_').collect! { |part| part.capitalize }.join + 'Interaction'
      interaction_class_name.constantize.new(io).run(*args)
    end
  end
end
