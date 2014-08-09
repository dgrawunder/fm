describe GetBalanceReport do

  let(:accounting_periods) do
    [
        create(:accounting_period, initial_deposit: 4003.56, name: 'First Accounting Period'),
        create(:accounting_period, initial_deposit: 358.37, name: 'Second Accounting Period')
    ]
  end
  let(:transactions) do
    create(:income, accounting_period_id: accounting_periods.first.id, amount: 5000)
    create(:income, accounting_period_id: accounting_periods.first.id, amount: 145)
    create(:income, accounting_period_id: accounting_periods.first.id, amount: 133, expected: true)
    create(:income, accounting_period_id: accounting_periods.first.id, amount: 5.45, expected: true)
    create(:income, accounting_period_id: accounting_periods.second.id)
    create(:expense, accounting_period_id: accounting_periods.first.id, amount: 800)
    create(:expense, accounting_period_id: accounting_periods.first.id, amount: 19.99)
    create(:expense, accounting_period_id: accounting_periods.first.id, amount: 45.50, expected: true)
    create(:expense, accounting_period_id: accounting_periods.first.id, amount: 12.87, expected: true)
    create(:expense, accounting_period_id: accounting_periods.second.id)
    create(:inpayment, accounting_period_id: accounting_periods.first.id, amount: 25)
    create(:inpayment, accounting_period_id: accounting_periods.first.id, amount: 250.25)
    create(:inpayment, accounting_period_id: accounting_periods.first.id, amount: 100, expected: true)
    create(:inpayment, accounting_period_id: accounting_periods.first.id, amount: 50, expected: true)
    create(:inpayment, accounting_period_id: accounting_periods.second.id)
    create(:outpayment, accounting_period_id: accounting_periods.first.id, amount: 1000)
    create(:outpayment, accounting_period_id: accounting_periods.first.id, amount: 100.33)
    create(:outpayment, accounting_period_id: accounting_periods.first.id, amount: 30, expected: true)
    create(:outpayment, accounting_period_id: accounting_periods.first.id, amount: 15.50, expected: true)
    create(:outpayment, accounting_period_id: accounting_periods.second.id)
    create(:receivable, amount: 20)
    create(:receivable, amount: 25.50)
    create(:receivable, amount: 30, expected: true)
    create(:receivable, amount: 10, expected: true)
  end

  it 'should return BalanceReport for AccountingPeriod of given id' do
    transactions
    subject = GetBalanceReport.new(accounting_periods.first.id)

    actual_balance = subject.run
    expect(actual_balance.accounting_period).to eq accounting_periods.first
    expect(actual_balance.incomes).to eq 5145
    expect(actual_balance.total_expected_incomes).to eq 5283.45
    expect(actual_balance.expenses).to eq 819.99
    expect(actual_balance.total_expected_expenses).to eq 878.36
    expect(actual_balance.inpayments).to eq 275.25
    expect(actual_balance.total_expected_inpayments).to eq 425.25
    expect(actual_balance.outpayments).to eq 1100.33
    expect(actual_balance.total_expected_outpayments).to eq 1145.83
    expect(actual_balance.receivables).to eq 45.50
    expect(actual_balance.total_expected_receivables).to eq 85.50
    expect(actual_balance.balance).to eq 4325.01
    expect(actual_balance.total_expected_balance).to eq 4405.09
    expect(actual_balance.credit).to eq 7457.99
    expect(actual_balance.total_expected_credit).to eq 7602.57
    expect(actual_balance.total_expected_credit_including_receivables).to eq 7648.07
  end

  it 'should return BalanceReport for AccountingPeriod with given name part if' do
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