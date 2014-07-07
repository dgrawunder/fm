class ValidationError < StandardError
  attr_reader :errors

  def initialize(errors)
    @errors = errors
  end

  def to_s
    errors.full_messages
  end

  def as_json
    errors.as_json
  end
end