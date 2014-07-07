class CreateCategory

  def initialize form
    @form = form
  end

  def run!
    @form.validate!
    Category.new(@form.attributes).save
  end

end