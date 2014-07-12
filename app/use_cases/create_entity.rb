class CreateEntity

  include EntityUseCaseHooks

  def initialize form
    @form = form
  end

  def run!
    run_before_validation(@form)
    @form.validate!
    entity_class.new(@form.attributes).save
  end

  private

  def entity_class
    @entity_class ||= self.class.name.gsub('Create', '').constantize
  end
end