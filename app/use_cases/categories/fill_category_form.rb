class FillCategoryForm

  def initialize id
    @id = id
  end

  def run!
    category = CategoryRepository.find(@id)
    form = CategoryForm.new
    CategoryForm.attribute_set.each do |attribute|
      form.public_send("#{attribute.name}=", category.public_send(attribute.name))
    end
    form
  end
end