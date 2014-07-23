class CreateEntityInteraction < FmCli::Interaction

  def run(form, entity_name)

    printable_entity_name = printable_entity_name(entity_name)

    begin
      entity = use_case_class(entity_name).new(form).run
      io.print_success "Successfully created #{printable_entity_name} #{entity.id}"
      io.send("print_#{entity_name.downcase}", entity)
    rescue ValidationError => e
      io.print_failure "#{printable_entity_name} couldn't be created to following errors:"
      io.print_form_errors(e.errors)
    end
  end

  private

  def printable_entity_name(entity_name)
    entity_name.to_s.capitalize
  end

  def use_case_class(entity_name)
    "Create#{entity_name.capitalize}".constantize
  end
end