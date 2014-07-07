class UpdateCategory

  def initialize(id, form)
    @id = id
    @form = form
  end

  def run!
    @form.validate!

    category = CategoryRepository.find(@id)
    @form.attributes.each do |attribute, value|
      category.public_send("#{attribute}=", value)
    end
    category.save
    category
  end
end