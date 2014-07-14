class UpdateEntity

  include EntityUseCaseHooks

  def initialize(id, form)
    @id = id
    @form = form
  end

  def run!
    run_before_validation(@form)
    @form.validate!

    entity = repository.find(@id)
    @form.attributes.each do |attribute, value|
      entity.public_send("#{attribute}=", value)
    end
    entity.save
    entity
  end

  private

  def repository
    @repository ||= "#{entity_name}Repository".constantize
  end

  def entity_name
    @entity_name ||= self.class.name.gsub('Update', '')
  end

end