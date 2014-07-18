class FillEntityForm

  def initialize id
    @id = id
  end

  def run
    entity = repository.find(@id)
    form = form_class.new
    form_class.attribute_set.each do |attribute|
      form.public_send("#{attribute.name}=", entity.public_send(attribute.name))
    end
    form
  end

  private

  def entity_class
    @entity_class ||= entity_name.constantize
  end

  def form_class
    @form_class ||= "#{entity_name}Form".constantize
  end

  def repository
    @repository ||= "#{entity_name}Repository".constantize
  end

  def entity_name
    @entity_name ||= self.class.name.gsub(/Fill|Form/, '')
  end
end