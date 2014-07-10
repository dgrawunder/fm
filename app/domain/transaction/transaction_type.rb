class TransactionType < Virtus::Attribute

  TYPES = {
      expense: 1,
      income: 2,
      outpayment: 3,
      inpayment: 4,
      receivable: 5
  }

  def coerce(value)
    value.is_a?(Fixnum) ? value : TransactionTypeFinder.find_number(value)
  end

  class << self

    def numbers
      TYPES.values
    end

    def [] name
      TYPES[name]
    end
  end
end