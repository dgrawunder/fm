describe TransactionRepository do

  subject { TransactionRepository }

  it 'should have query method for every TransactionType except receivable returning all transactions of given type AccountingPeriod id' do
    expense_1 = create(:expense, accounting_period_id: 5)
    expense_2 = create(:expense, accounting_period_id: 5)
    create(:expense, accounting_period_id: 6)
    income = create(:income, accounting_period_id: 5)
    inpayment = create(:inpayment, accounting_period_id: 5)
    outpayment = create(:outpayment, accounting_period_id: 5)

    expect(subject.expenses_by_accounting_period_id(5)).to eq [expense_1, expense_2]
    expect(subject.incomes_by_accounting_period_id(5)).to eq [income]
    expect(subject.inpayments_by_accounting_period_id(5)).to eq [inpayment]
    expect(subject.outpayments_by_accounting_period_id(5)).to eq [outpayment]
    expect(subject).not_to respond_to(:receivables_by_accounting_period_id)
  end

  describe '::receivables' do

    it 'should return all receivables not being a template' do
      receivable_1 = create(:receivable)
      receivable_2 = create(:receivable)
      create(:receivable, template: true)
      create(:expense)
      expect(subject.receivables).to eq [receivable_1, receivable_2]
    end
  end

  describe '::templates' do

    it 'should return all templates' do
      template_1 = create(:template)
      template_2 = create(:template)
      create(:expense)
      expect(subject.templates).to eq [template_1, template_2]

    end
  end

  describe '::all_by_accounting_period_id' do

    it 'should return all transactions of given AccountingPeriod-id' do
      transaction_1 = create(:expense, accounting_period_id: 5)
      transaction_2 = create(:income, accounting_period_id: 5)
      create(:expense, accounting_period_id: 6)

      expect(subject.all_by_accounting_period_id(5)).to eq [transaction_1, transaction_2]
    end

  end

  describe '::search' do

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

    context 'if term present' do

      it 'should use it as search term for description' do
        transaction_1 = create(:expense, description: 'A Food Store 1')
        transaction_2 = create(:expense, description: 'A Food Store 2')
        create(:expense)

        criteria = TransactionSearchForm.new(term: 'Food Store')
        expect(subject.search(criteria)).to eq [transaction_1, transaction_2]
      end

      it 'should use it as search term for amount' do
        transaction_1 = create(:expense, amount: 34.90)
        create(:expense, amount: 34.99)

        criteria = TransactionSearchForm.new(term: '34.90')
        expect(subject.search(criteria)).to eq [transaction_1]
      end

      it 'should use it as search term for category names' do
        category_1 = create(:expense_category, name: 'First Food Category')
        transaction_1 = create(:expense, category_id: category_1.id)
        create(:expense)

        criteria = TransactionSearchForm.new(term: 'Food')
        expect(subject.search(criteria)).to eq [transaction_1]
      end
    end
  end

end