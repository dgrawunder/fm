module FmCli
  class EntityInteraction < FmCli::Interaction

    private

    def entity_name(entity_identifier)
      entity_identifier.to_s.split('_').collect! {|part| part.capitalize }.join
    end

    def printable_entity_name(entity_identifier)
      entity_identifier.to_s.split('_').join(' ')
    end
  end
end