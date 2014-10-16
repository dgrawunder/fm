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

NoCurrentAccountingPeriodError = Class.new StandardError
RecordNotFoundError = Class.new StandardError
UnknownTransactionTypeError = Class.new StandardError
UnknownAccountingPeriodError = Class.new StandardError
UnknownCategoryError = Class.new StandardError
