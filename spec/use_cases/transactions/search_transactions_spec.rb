describe SearchTransactions do

  let(:type_name) { 'exp' }
  let(:transactions) do
    [
        create(:expense, date: 3.days.ago),
        create(:expense, date: 1.day.ago),
        create(:expense, date: 2.days.ago),
        create(:income),
        create(:receivable, date: 1.day.ago),
        create(:receivable, date: 2.days.ago)
    ]
  end
  let(:form) { TransactionSearchForm.new(type: type_name) }

  subject { SearchTransactions.new form }

  before :each do
    transactions
  end

  it 'should return all transactions matches given search and order them by date desc when form has no sort' do
    expect(subject.run).to eq [transactions.second, transactions.third, transactions.first]
  end

  it 'should order transaction by form.sort when present' do
    form.sort = :id
    expect(subject.run).to eq [transactions.first, transactions.second, transactions.third]
  end

  # context 'when receivables are requested' do
  #
  #   let(:type_name) { 'recei' }
  #
  #   it 'should return all' do
  #     expect(subject.run).to eq [transactions[5], transactions[6]]
  #   end
  # end
end