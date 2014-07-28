module FmCli
  class DeleteEntityInteraction < FmCli::EntityInteraction

    def run(id, entity_identifier)

      entity_name = entity_name(entity_identifier)
      printable_entity_name = printable_entity_name(entity_identifier)

      begin
        entity = find_entity_use_case_class(entity_name).new(id).run
        io.print "Requested to delete #{printable_entity_name}:"
        io.print_blank_line
        io.send("print_#{entity_identifier}", entity)
        io.print_blank_line

        if io.answered_yes?("Should really be deleted?")
          delete_entity_use_case_class(entity_name).new(id).run
          io.print_success("Successfully deleted #{printable_entity_name} with id='#{id}'")
        end
      rescue RecordNotFoundError
        io.print_failure "Couldn't find #{printable_entity_name} with id='#{id}'"
      end
    end

    def find_entity_use_case_class(entity_name)
      "Find#{entity_name}".constantize
    end

    def delete_entity_use_case_class(entity_name)
      "Delete#{entity_name}".constantize
    end
  end
end