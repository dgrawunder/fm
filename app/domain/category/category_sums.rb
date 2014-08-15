class CategorySums

  attr_accessor :category

  delegate :actual_sum, :expected_sum, :total_expected_sum, to: :transaction_sums

  def initialize category, transactions
    @category, @transactions = category, transactions
  end

  private

  def transaction_sums
    @transaction_sums ||= TransactionSums.create(@transactions)
  end

end