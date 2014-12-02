describe SearchTransactions do

  let(:current_accounting_period_id) { 7 }
  let(:type_name) { 'exp' }
  let(:transactions) do
    [
        create(:expense, date: 3.days.ago,  accounting_period_id: current_accounting_period_id),
        create(:expense, date: 1.day.ago),
        create(:expense, date: 2.days.ago,  accounting_period_id: current_accounting_period_id),
        create(:income),
        create(:outpayment, date: 1.day.ago),
        create(:outpayment, date: 2.days.ago),
        create(:expense, day_of_month: 3, template: true),
        create(:expense, day_of_month: 1, template: true),
        create(:expense, day_of_month: 2, template: true),
        create(:income, template: true)
    ]
  end
  let(:form) { TransactionSearchForm.new(type: type_name, sort: :id) }

  subject { SearchTransactions.new form }

  before :each do
    transactions
  end

  context 'no templates' do

    before :each do
      form.template = false
    end

    it 'should return all transactions matches given search and order them by given sort' do
      expect(subject.run).to eq [transactions.first, transactions.second, transactions.third]
    end

    it 'should order transaction by date desc when form has no sort' do
      form.sort = nil
      expect(subject.run).to eq [transactions.second, transactions.third, transactions.first]
    end

    context 'when only_currents is true' do

      before :each do
        create(:current_accounting_period_id_property, value: current_accounting_period_id)
      end

      subject { SearchTransactions.new(form, only_currents: true) }

      it 'should search only for current transactions' do
        expect(subject.run).to eq [transactions.first, transactions.third]
      end
    end
  end

  context 'only templates' do

    before :each do
      form.template = true
    end

    it 'should return all templates matches given search and order them by given sort' do
      expect(subject.run).to eq [transactions[6], transactions[7], transactions[8]]
    end

    it 'should order templates by day_of_month asc when form has no sort' do
      form.sort = nil
      expect(subject.run).to eq [transactions[6], transactions[8], transactions[7]]
    end
  end
end