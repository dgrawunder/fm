class DeleteCategory

  def initialize id
    @id = id
  end

  def run!
    CategoryRepository.delete(@id)
  end

end