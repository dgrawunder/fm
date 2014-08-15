describe TransactionSums do

  describe '::create' do
    
    subject { TransactionSums }

    it 'should create TransactionSum with correctly calculated sums' do
      transactions = [
          Transaction.new(amount: 34.56, expected: false),
          Transaction.new(amount: 12.78, expected: false),
          Transaction.new(amount: 5.56, expected: true),
          Transaction.new(amount: 14.50, expected: true)
      ]

      actual_transaction_sums = subject.create(transactions)

      expect(actual_transaction_sums.actual_sum).to eq 47.34
      expect(actual_transaction_sums.expected_sum).to eq 20.06
      expect(actual_transaction_sums.total_expected_sum).to eq 67.40
    end

    it 'should have 0 as default value for every sum if transactions are nil' do
      actual_transaction_sums = subject.create(nil)

      expect(actual_transaction_sums.actual_sum).to eq 0
      expect(actual_transaction_sums.expected_sum).to eq 0
      expect(actual_transaction_sums.total_expected_sum).to eq 0
    end
  end
end