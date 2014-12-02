class TransactionType < Virtus::Attribute

  TYPES = {
      expense: 1,
      income: 2,
      outpayment: 3,
      inpayment: 4
  }

  def coerce(value)
    value.is_a?(Fixnum) ? value : self.class.find_number(value)
  end

  class << self

    def numbers
      TYPES.values
    end

    def names
      TYPES.keys
    end

    def [](name)
      TYPES[name]
    end

    def find_name(number)
      TYPES.find { |key, value| value == number }.try(:first)
    end

    def find_number(text)
      target_number = nil

      if text.present?
        TYPES.each do |transaction_type, number|
          if transaction_type.to_s.match /^#{text}/
            target_number = number
            break
          end
        end
      end
      target_number
    end
  end
end