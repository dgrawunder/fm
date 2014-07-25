module FmCli
  class DeleteEntityInteraction < FmCli::EntityInteraction

    def run(id, entity_name)

      printable_entity_name = printable_entity_name(entity_name)

      begin
        io.print_blank_line
        io.print "Requested to delete #{printable_entity_name}:"
        entity = find_entity_use_case_class(printable_entity_name).new(id).run
        io.send("print_#{entity_name.downcase}", entity)
        if io.answered_yes?("Should delete?")
          delete_entity_use_case_class(printable_entity_name).new(id).run
          io.print_success("Successfully deleted #{printable_entity_name} #{id}")
        end
      rescue RecordNotFoundError
        io.print_failure "Couldn't find #{printable_entity_name} with Id='#{id}'"
      end
      io.print_blank_line
    end

    def find_entity_use_case_class(entity_name)
      "Find#{entity_name}".constantize
    end

    def delete_entity_use_case_class(entity_name)
      "Delete#{entity_name}".constantize
    end
  end
end