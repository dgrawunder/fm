module FmCli
  class EntityInteraction < FmCli::Interaction

    private

    def printable_entity_name(entity_name)
      entity_name.to_s.capitalize
    end
  end
end