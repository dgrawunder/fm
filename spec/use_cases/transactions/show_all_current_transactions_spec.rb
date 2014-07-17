describe ShowAllCurrentTransactions do

  let(:current_accounting_period_id) { 7 }
  let(:type_name) { 'exp' }
  let(:categories) do
    [
        create(:expense_category),
        create(:expense_category)
    ]
  end
  let(:transactions) do
    [
        create(:expense, accounting_period_id: current_accounting_period_id, category_id: categories.first.id,
               date: 3.days.ago),
        create(:expense, accounting_period_id: current_accounting_period_id, category_id: categories.second.id,
               date: 1.day.ago),
        create(:expense, accounting_period_id: current_accounting_period_id, date: 2.days.ago),
        create(:expense, accounting_period_id: current_accounting_period_id + 1),
        create(:income, accounting_period_id: current_accounting_period_id),
        create(:receivable, date: 1.day.ago),
        create(:receivable, date: 2.days.ago)
    ]
  end

  subject { ShowAllCurrentTransactions.new type_name }

  before :each do
    create(:current_accounting_period_id_property, value: 7)
    transactions
  end

  it 'should return all transactions of given partial type_name with included categories sorted by date desc' do

    actual_transactions = subject.run!
    expect(actual_transactions).to eq [transactions.second, transactions.third, transactions.first]

    expect(actual_transactions.first.category).to eq categories.second
    expect(actual_transactions.second.category).to be_nil
    expect(actual_transactions.third.category).to eq categories.first
  end

  context 'when receivables are requested' do

    let(:type_name) { 'recei' }

    it 'should return all' do
      expect(subject.run!).to eq [transactions[5], transactions[6]]
    end
  end

  context 'when type_name is could not found' do

    let(:type_name) { 'foo' }

    it 'should throw UnknownTransactionType' do
      expect { subject.run! }.to raise_error UnknownTransactionTypeError
    end
  end
end