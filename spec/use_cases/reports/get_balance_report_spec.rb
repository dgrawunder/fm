describe GetBalanceReport do

  let(:accounting_periods) do
    [
        create(:accounting_period, initial_deposit: 4003.56, name: 'First Accounting Period'),
        create(:accounting_period, initial_deposit: 358.37, name: 'Second Accounting Period')
    ]
  end

  it 'should return BalanceReport for AccountingPeriod of given id' do
    subject = GetBalanceReport.new(accounting_periods.first.id)
    expect(subject.run.accounting_period).to eq accounting_periods.first
  end

  it 'should return BalanceReport for AccountingPeriod of given name part if' do
    accounting_periods
    subject = GetBalanceReport.new('First Accounting Period')
    expect(subject.run.accounting_period).to eq accounting_periods.first
  end

  it 'should return BalanceReport for current AccountingPeriod when no identifier given' do
    create(:current_accounting_period_id_property, value: accounting_periods.second.id)
    subject = GetBalanceReport.new
    expect(subject.run.accounting_period).to eq accounting_periods.second
  end

end