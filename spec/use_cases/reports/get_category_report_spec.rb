describe GetCategoryReport do

  let(:accounting_periods) do
    [
        build(:accounting_period, id: 5),
        build(:accounting_period, id: 6)
    ]
  end

  let(:categories) do
    [
        create(:expense_category),
        create(:expense_category),
        create(:expense_category),
        create(:expense_category),
        create(:income_category)
    ]
  end

  let(:transactions) do
    [
        create(:expense, accounting_period_id: accounting_periods.second.id, category_id: categories.first.id, amount: 25.99),
        create(:expense, accounting_period_id: accounting_periods.second.id, category_id: categories.first.id, amount: 36.99),
        create(:expense, accounting_period_id: accounting_periods.second.id, category_id: categories.first.id, amount: 37.50),
        create(:expense, accounting_period_id: accounting_periods.second.id, category_id: categories.second.id, amount: 598.56),
        create(:expense, accounting_period_id: accounting_periods.second.id, category_id: categories.second.id, amount: 23.5),
        create(:expense, accounting_period_id: accounting_periods.second.id, category_id: categories.third.id, amount: 78),
        create(:expense, accounting_period_id: accounting_periods.second.id, amount: 11.20),
        create(:expense, accounting_period_id: accounting_periods.second.id, amount: 15),
        create(:expense, ategory_id: categories.first.id, amount: 37.50, template: true),
        create(:expense, accounting_period_id: accounting_periods.first.id, category_id: categories.second.id, amount: 55),
        create(:income, accounting_period_id: accounting_periods.second.id, category_id: categories.fifth.id, amount: 300)
    ]
  end

  subject { GetCategoryReport.new('exp') }

  context 'if current AccountingPeriod does exists' do

    before :each do
      create(:current_accounting_period_id_property, value: accounting_periods.second.id)
    end

    # it 'it should return current TransactionSums for all Categories of given TransactionType' do
    #
    #   actual_transaction_sums = subject.run
    #   expect(actual_transaction_sums.count).to eq 5
    # end

    it 'should throw UnknownTransactionTypeError if given TransactionType name part is invalid' do
      subject = GetCategoryReport.new('foo')
      expect { subject.run }.to raise_error UnknownTransactionTypeError
    end
  end

  context 'if current AccountingPeriod does not exist' do

    it 'should throw NoCurrentAccountingPeriodError' do
      expect { subject.run }.to raise_error NoCurrentAccountingPeriodError
    end
  end

end