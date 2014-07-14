describe UpdateTransaction do

  let(:accounting_period) { create(:accounting_period, name: 'Accounting Period 1') }
  let(:category) { create(:expense_category, name: 'Category 1') }

  let(:transaction) do
    create(:expense, description: 'Description 1')
  end

  let(:form) do
    TransactionForm.new(
        accounting_period_id: accounting_period.id,
        category_id: category.id,
        description: 'Description 1',
        amount: 20.3,
        date: '05.04',
        type: TransactionType[:expense],
    )
  end

  subject { UpdateTransaction.new(transaction.id, form) }

  it 'should update transaction' do
    actual_transaction = subject.run!

    expect(actual_transaction).to be_instance_of Transaction
    expect(actual_transaction.description).to eq 'Description 1'

    stored_transaction = TransactionRepository.find(transaction.id)
    expect(stored_transaction.description).to eq 'Description 1'
  end

  it 'should resolve AccountingPeriod-Id and Category-Id' do
    form.accounting_period_id = nil
    form.category_id = nil
    form.accounting_period_name = 'Period'
    form.category_name = 'Cat'

    actual_transaction = subject.run!
    expect(actual_transaction.accounting_period_id).to eq accounting_period.id
    expect(actual_transaction.category_id).to eq category.id
  end

  it 'should throw ValidationError when given form is invalid' do
    form.description = nil
    expect { subject.run! }.to raise_error ValidationError
    expect( TransactionRepository.find(transaction.id).description).to eq transaction.description
  end

end