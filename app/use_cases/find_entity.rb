class FindEntity

  def initialize id
    @id = id
  end

  def run
    repository.find(@id)
  end

  private

  def repository
    @repository ||= "#{entity_name}Repository".constantize
  end

  def entity_name
    @entity_name ||= self.class.name.gsub(/Find/, '')
  end
end