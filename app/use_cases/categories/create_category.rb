class CreateCategory

  def initialize form
    @form = form
  end

  def run!
    @form.validate!

    category = Category.new(@form.attributes)
    CategoryRepository.create(category)
  end

end