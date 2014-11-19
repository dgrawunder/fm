describe GetCategoryReport do

  let(:accounting_periods) do
    [
        build(:accounting_period, id: 5),
        build(:accounting_period, id: 6)
    ]
  end

  let(:categories) do
    [
        create(:expense_category, name: 'Category 3'),
        create(:expense_category, name: 'Category 1'),
        create(:expense_category, name: 'Category 2'),
        create(:income_category),
        create(:receivable_category, name: 'Category 5'),
        create(:receivable_category, name: 'Category 6')
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
        create(:expense, category_id: categories.first.id, amount: 37.50, template: true),
        create(:expense, accounting_period_id: accounting_periods.first.id, category_id: categories.second.id, amount: 55),
        create(:income, accounting_period_id: accounting_periods.second.id, category_id: categories.fifth.id, amount: 300),
        create(:receivable, accounting_period_id: accounting_periods.second.id, category_id: categories[4].id, amount: 56.80),
        create(:receivable, accounting_period_id: accounting_periods.second.id, category_id: categories[4].id, amount: 87.90),
        create(:receivable, accounting_period_id: accounting_periods.second.id, category_id: categories[5].id, amount: 87),
        create(:receivable,  category_id: categories[5].id, template: true)
    ]
  end

  subject { GetCategoryReport.new('exp') }

  before :each do
    transactions
  end

  context 'if current AccountingPeriod does exists' do

    before :each do
      create(:current_accounting_period_id_property, value: accounting_periods.second.id)
    end

    it 'should return all current CategorySums for all Categories of given TransactionType ordered by Category name' do

      actual_category_sums = subject.run
      expect(actual_category_sums.count).to eq 3
      expect(actual_category_sums.first.category).to eq categories.second
      expect(actual_category_sums.first.actual_sum).to eq BigDecimal.new('622.06')
      expect(actual_category_sums.second.category).to eq categories.third
      expect(actual_category_sums.second.actual_sum).to eq BigDecimal.new('78.0')
      expect(actual_category_sums.third.category).to eq categories.first
      expect(actual_category_sums.third.actual_sum).to eq BigDecimal.new('100.48')
    end

    it 'should return CategorySums for Category with no Transaction' do
      expected_category = create(:expense_category, name: 'Category 4')

      actual_category_sums = subject.run
      expect(actual_category_sums.count).to eq 4
      expect(actual_category_sums.last.category).to eq expected_category
      expect(actual_category_sums.last.actual_sum).to eq BigDecimal.new('0.0')
    end

    it 'should return CategorySums with no Category for Transaction without a Category' do
      create(:expense, accounting_period_id: accounting_periods.second.id, amount: 11.20)
      create(:expense, accounting_period_id: accounting_periods.second.id, amount: 15)
      create(:income, accounting_period_id: accounting_periods.second.id, amount: 12)

      actual_category_sums = subject.run
      expect(actual_category_sums.count).to eq 4
      expect(actual_category_sums.last.category).to be_nil
      expect(actual_category_sums.last.actual_sum).to eq BigDecimal.new('26.20')
    end

    it 'should throw UnknownTransactionTypeError if given TransactionType name part is invalid' do
      subject = GetCategoryReport.new('foo')
      expect { subject.run }.to raise_error UnknownTransactionTypeError
    end

    it 'should return all Receivables if requested' do
      subject = GetCategoryReport.new('rec')

      actual_category_sums = subject.run
      expect(actual_category_sums.count).to eq 2
      expect(actual_category_sums.first.category).to eq categories[4]
      expect(actual_category_sums.first.actual_sum).to eq BigDecimal.new('144.7')
      expect(actual_category_sums.second.category).to eq categories[5]
      expect(actual_category_sums.second.actual_sum).to eq BigDecimal.new('87.0')
    end
  end

  context 'if current AccountingPeriod does not exist' do

    it 'should throw NoCurrentAccountingPeriodError' do
      expect { subject.run }.to raise_error NoCurrentAccountingPeriodError
    end
  end

end