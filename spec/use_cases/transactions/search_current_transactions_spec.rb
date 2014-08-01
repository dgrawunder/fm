describe SearchCurrentTransactions do

  let(:current_accounting_period_id) { 7 }
  let(:type_name) { 'exp' }
  let(:transactions) do
    [
        create(:expense, accounting_period_id: current_accounting_period_id, date: 3.days.ago),
        create(:expense, accounting_period_id: current_accounting_period_id, date: 1.day.ago),
        create(:expense, accounting_period_id: current_accounting_period_id, date: 2.days.ago),
        create(:expense, accounting_period_id: current_accounting_period_id + 1),
        create(:income, accounting_period_id: current_accounting_period_id),
        create(:receivable, date: 1.day.ago),
        create(:receivable, date: 2.days.ago)
    ]
  end
  let(:form) { TransactionSearchForm.new(type: type_name) }

  subject { SearchCurrentTransactions.new form }

  before :each do
    create(:current_accounting_period_id_property, value: 7)
    transactions
  end

  it 'should return all transactions matches given search and belong to current accounting period and order them by date desc when form has no sort' do
    actual_transactions = subject.run
    expect(actual_transactions).to eq [transactions.second, transactions.third, transactions.first]
  end

  context 'when receivables are requested' do

    let(:type_name) { 'recei' }

    it 'should return all' do
      expect(subject.run).to eq [transactions[5], transactions[6]]
    end
  end
end