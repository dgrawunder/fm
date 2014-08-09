class TransactionSums

  include Lift

  attr_accessor :actual_sum
  attr_accessor :expected_sum
  attr_accessor :total_expected_sum

  def self.create(transactions)
    actual_sum = expected_sum = 0

    transactions.each do |transaction|
      if transaction.expected?
          expected_sum += transaction.amount
      else
          actual_sum += transaction.amount
      end
    end

    TransactionSums.new(actual_sum: actual_sum,
                        expected_sum: expected_sum,
                        total_expected_sum: actual_sum + expected_sum)
  end
end