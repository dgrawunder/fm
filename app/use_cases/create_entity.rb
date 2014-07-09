class CreateEntity

  def initialize form
    @form = form
  end

  def run!
    @form.validate!
    entity_class.new(@form.attributes).save
  end

  private

  def entity_class
    @entity_class ||= self.class.name.gsub('Create', '').constantize
  end
end