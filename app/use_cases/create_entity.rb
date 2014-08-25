class CreateEntity

  include EntityUseCaseHooks

  def initialize form
    @form = form
  end

  def run
    run_before_validation(@form)
    @form.validate!
    entity = entity_class.new(@form.attributes)
    entity.save
    run_after_save(entity)
    entity
  end

  private

  def entity_class
    @entity_class ||= self.class.name.gsub('Create', '').constantize
  end
end