module TransactionTypeFinder
  extend self

  def find_number text
    target_number = nil

    if text.present?
      TransactionType::TYPES.each do |transaction_type, number|
        if transaction_type.to_s.match /^#{text}/
          target_number = number
          break
        end
      end
    end
    target_number
  end
end