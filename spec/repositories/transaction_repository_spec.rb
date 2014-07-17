describe TransactionRepository do

  subject { TransactionRepository }

  describe '#search' do

    it 'should return all Transaction if empty criteria given' do
      create(:expense)
      create(:income)
      create(:receivable)
      criteria = TransactionSearchForm.new
      expect(subject.search(criteria).count).to eq 3
    end

    it 'should return all by given type and accounting_period_id and sort' do
      expense_3 = create(:expense, accounting_period_id: 2, date: 3.days.ago)
      expense_1 = create(:expense, accounting_period_id: 2, date: 1.days.ago)
      expense_2 = create(:expense, accounting_period_id: 2, date: 2.days.ago)
      create(:income, accounting_period_id: 2)
      create(:expense, accounting_period_id: 3)
      criteria = TransactionSearchForm.new(
          accounting_period_id: 2, type: TransactionType[:expense], sort: 'date desc')

      expect(subject.search(criteria)).to eq [expense_1, expense_2, expense_3]
    end

    it 'should set category if given as included association' do
      category_1 = create(:expense_category)
      category_2 = create(:income_category)
      create(:expense, category_id: category_1.id)
      create(:income, category_id: category_2.id)

      criteria = TransactionSearchForm.new
      actual_transactions = subject.search(criteria, include: :category)

      expect(actual_transactions.first.category).to eq category_1
      expect(actual_transactions.second.category).to eq category_2
    end
  end

end