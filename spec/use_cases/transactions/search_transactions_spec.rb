describe SearchTransactions do

  let(:type_name) { 'exp' }
  let(:transactions) do
    [
        create(:expense, date: 3.days.ago),
        create(:expense, date: 1.day.ago),
        create(:expense, date: 2.days.ago),
        create(:income),
        create(:receivable, date: 1.day.ago),
        create(:receivable, date: 2.days.ago),
        create(:expense, day_of_month: 3, template: true),
        create(:expense, day_of_month: 1, template: true),
        create(:expense, day_of_month: 2, template: true),
        create(:income, template: true)
    ]
  end
  let(:form) { TransactionSearchForm.new(type: type_name) }

  subject { SearchTransactions.new form }

  before :each do
    transactions
  end

  context 'no templates' do

    before :each do
      form.template = false
    end

    it 'should return all transactions matches given search and order them by date desc when form has no sort' do
      expect(subject.run).to eq [transactions.second, transactions.third, transactions.first]
    end

    it 'should order transaction by form.sort when present' do
      form.sort = :id
      expect(subject.run).to eq [transactions.first, transactions.second, transactions.third]
    end
  end

  context 'only templates' do

    before :each do
      form.template = true
    end

    it 'should return all templates matches given search and order them by date desc when form has no sort' do
      expect(subject.run).to eq [transactions[7], transactions[8], transactions[6]]
    end

    it 'should order templates by form.sort when present' do
      form.sort = :id
      expect(subject.run).to eq [transactions[6], transactions[7], transactions[8]]
    end
  end
end