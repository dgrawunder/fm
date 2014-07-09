describe UpdateAccountingPeriod do

  let(:accounting_period) do
    create(:accounting_period, name: 'accounting_period 1', starts_at: 30.days.ago, ends_at: 1.day.ago)
  end

  let(:form) { AccountingPeriodForm.new name: 'accounting_period 2', starts_at: 1.day.ago, ends_at: 30.days.from_now}

  subject { UpdateAccountingPeriod.new(accounting_period.id, form) }

  it 'should update AccountingPeriod' do

    actual_accounting_period = subject.run!

    expect(actual_accounting_period.name).to eq form.name

    stored_accounting_period = AccountingPeriodRepository.find(accounting_period.id)
    expect(stored_accounting_period.starts_at).to eq form.starts_at
  end
end