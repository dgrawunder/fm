module Associations

  def self.included(descendant)
    descendant.extend ClassMethods
  end

  module ClassMethods

    def belongs_to entity_name
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{entity_name}
          @#{entity_name} ||= begin
            repository.find(self.#{entity_name}_id) if self.#{entity_name}_id.present?
          end
        end

        def #{entity_name}=(entity)
          @#{entity_name} = entity
          self.#{entity_name}_id = entity.nil? ? nil : entity.id
        end
      CODE
    end
  end
end