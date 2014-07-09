class Entity
  include Lift
  include Equalizer.new(:id)

  attr_accessor :id

  def save
    if persisted?
      repository.update self
    else
      repository.create self
    end
  end
  alias save! save

  def new_record?
    id.nil?
  end

  def persisted?
    !new_record?
  end

  private

  def repository
    @repo ||= "#{self.class.name}Repository".constantize
  end

end