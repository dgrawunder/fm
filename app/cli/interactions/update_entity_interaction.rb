module FmCli
  class UpdateEntityInteraction < EntityInteraction

    def run(id, attributes, entity_name)

      printable_entity_name = printable_entity_name(entity_name)

      begin

        form = fill_form_use_case_class(printable_entity_name).new(id).run
        attributes.each do |attribute, value|
          form.public_send("#{attribute}=", value)
        end
        entity = update_entity_use_case_class(printable_entity_name).new(id, form).run

        io.print_success "Successfully updated #{printable_entity_name} #{entity.id}"
        io.send("print_#{entity_name.downcase}", entity)
      rescue ValidationError => e
        io.print_failure "#{printable_entity_name} couldn't be updated to following errors:"
        io.print_errors(e.errors)
      rescue RecordNotFoundError
        io.print_failure "Couldn't find #{printable_entity_name} wit Id='#{id}'"
      end

    end

    private

    def fill_form_use_case_class(entity_name)
      "Fill#{entity_name}Form".constantize
    end

    def update_entity_use_case_class(entity_name)
      "Update#{entity_name}".constantize
    end
  end

end
