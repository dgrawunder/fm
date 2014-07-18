class DeleteEntity

  def initialize id
    @id = id
  end

  def run
    repository.delete(@id)
  end

  private

  def repository
    @repository ||= "#{self.class.name.gsub('Delete', '')}Repository".constantize
  end

end