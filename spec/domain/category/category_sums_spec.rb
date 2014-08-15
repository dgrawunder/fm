describe CategorySums do

  let(:transactions) do
    [
        Transaction.new(amount: 34.56, expected: false),
        Transaction.new(amount: 12.78, expected: false),
        Transaction.new(amount: 5.56, expected: true),
        Transaction.new(amount: 14.50, expected: true)
    ]
  end

  it 'should provide correct sums of given Transactions' do
    subject = CategorySums.new(Category.new, transactions)

    expect(subject.actual_sum).to eq 47.34
    expect(subject.expected_sum).to eq 20.06
    expect(subject.total_expected_sum).to eq 67.40
  end


  it 'should have 0 as default value for every sum if transaction are nil' do
    subject = CategorySums.new(Category.new, nil)

    expect(subject.actual_sum).to eq 0
    expect(subject.expected_sum).to eq 0
    expect(subject.total_expected_sum).to eq 0
  end
end