describe AccountingPeriod do

  let(:form) do
    AccountingPeriodForm.new(
        name: 'Period 1',
        starts_at: Date.new(2014, 6, 29),
        ends_at: Date.new(2014, 7, 29),
        initial_deposit: BigDecimal.new(5000))
  end

  subject { CreateAccountingPeriod.new(form) }

  it 'should create AccountingPeriod' do
    actual_accounting_period = subject.run

    expect(actual_accounting_period).to be_instance_of AccountingPeriod

    persisted_actual_accounting_period = AccountingPeriodRepository.find(actual_accounting_period.id)
    expect(persisted_actual_accounting_period.name).to eq form.name
    expect(persisted_actual_accounting_period.starts_at).to eq form.starts_at
    expect(persisted_actual_accounting_period.ends_at).to eq form.ends_at
    expect(persisted_actual_accounting_period.initial_deposit).to eq form.initial_deposit
  end

  it 'should create transaction from templates for new AccountingPeriod' do
    template_1 = create(:template, day_of_month: 7)
    create(:template)

    actual_accounting_period = subject.run

    actual_transactions = TransactionRepository.all
    expect(actual_transactions.count).to eq 2

    transaction_1 = actual_transactions.first
    expect(transaction_1.accounting_period_id).to eq actual_accounting_period.id
    expect(transaction_1.amount).to eq template_1.amount
    expect(transaction_1.type).to eq template_1.type
    expect(transaction_1.date).to eq Date.new(2014, 7, 7)
    expect(transaction_1.template).to eq false
    expect(transaction_1.day_of_month).to be_nil
  end

  it 'should throw ValidationError when given form is invalid' do
    form.name = nil
    expect { subject.run }.to raise_error ValidationError
    expect(AccountingPeriodRepository.count).to eq 0
  end
end