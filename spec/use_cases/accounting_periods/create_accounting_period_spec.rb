describe AccountingPeriod do

  let(:form) do
    AccountingPeriodForm.new(
        name: 'Period 1',
        starts_at: Date.new,
        ends_at: Date.new + 30.days,
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

  it 'should throw ValidationError when given form is invalid' do
    form.name = nil
    expect { subject.run }.to raise_error ValidationError
    expect(AccountingPeriodRepository.count).to eq 0
  end
end