describe CreateTransaction do

  let(:accounting_period) { create(:accounting_period, name: 'Accounting Period 1') }
  let(:category) { create(:income_category, name: 'Category 1') }

  let(:form) do
    TransactionForm.new(
        accounting_period_id: accounting_period.id,
        category_id: category.id,
        description: 'Expense 1',
        amount: 20.3,
        date: '05.04',
        type: 'incom',
        expected: true
    )
  end

  subject { CreateTransaction.new(form) }

  it 'should create Transaction' do
    actual_transaction = subject.run
    expect(actual_transaction).to be_instance_of Transaction

    stored_transaction = TransactionRepository.find(actual_transaction.id)
    expect(stored_transaction.accounting_period_id).to eq accounting_period.id
    expect(stored_transaction.category_id).to eq category.id
    expect(stored_transaction.description).to eq form.description
    expect(stored_transaction.amount).to eq form.amount
    expect(stored_transaction.date).to eq Date.new(Time.now.year, 4, 5)
    expect(stored_transaction.type).to eq TransactionType[:income]
    expect(stored_transaction.expected).to be true
  end

  it 'should resolve AccountingPeriod-Id and Category-Id' do
    form.accounting_period_id = nil
    form.accounting_period_name = 'Account'
    form.category_id = nil
    form.category_name = 'Cat'

    actual_transaction = subject.run
    expect(actual_transaction.accounting_period_id).to eq accounting_period.id
    expect(actual_transaction.category_id).to eq category.id
  end

  it 'should create template' do
    form.template = true
    form.day_of_month = 3
    actual_transaction = subject.run

    expect(TransactionRepository.find(actual_transaction.id).template).to be true
  end

  context 'if no AccountingPeriod id or name is set' do

    before :each do
      form.accounting_period_id = nil
      form.accounting_period_name = nil

      create(:current_accounting_period_id_property, value: accounting_period.id)
    end

    it 'should take current AccountingPeriod' do
      actual_transaction = subject.run
      expect(TransactionRepository.find(actual_transaction.id).accounting_period_id).to eq accounting_period.id
    end

    it 'should not take current AccountingPeriod if transaction is template' do
      form.template = true
      form.day_of_month = 3
      actual_transaction = subject.run
      expect(TransactionRepository.find(actual_transaction.id).accounting_period_id).to be nil
    end
  end

  it 'should throw ValidationError when given form is invalid' do
    form.description = nil
    expect { subject.run }.to raise_error ValidationError
    expect(TransactionRepository.count).to eq 0
  end

end