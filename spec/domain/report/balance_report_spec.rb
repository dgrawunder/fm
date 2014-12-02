describe BalanceReport do

  let(:accounting_period) do
    build(:accounting_period, id: 5, initial_deposit: 4003.56)
  end

  let(:transactions) do
    create(:income, accounting_period_id: accounting_period.id, amount: 5000)
    create(:income, accounting_period_id: accounting_period.id, amount: 145)
    create(:income, accounting_period_id: accounting_period.id, amount: 133, expected: true)
    create(:income, accounting_period_id: accounting_period.id, amount: 5.45, expected: true)
    create(:income, accounting_period_id: accounting_period.id + 1)
    create(:income, template: true)
    create(:expense, accounting_period_id: accounting_period.id, amount: 800)
    create(:expense, accounting_period_id: accounting_period.id, amount: 19.99)
    create(:expense, accounting_period_id: accounting_period.id, amount: 45.50, expected: true)
    create(:expense, accounting_period_id: accounting_period.id, amount: 12.87, expected: true)
    create(:expense, accounting_period_id: accounting_period.id + 1)
    create(:expense, template: true)
    create(:inpayment, accounting_period_id: accounting_period.id, amount: 25)
    create(:inpayment, accounting_period_id: accounting_period.id, amount: 250.25)
    create(:inpayment, accounting_period_id: accounting_period.id, amount: 100, expected: true)
    create(:inpayment, accounting_period_id: accounting_period.id, amount: 50, expected: true)
    create(:inpayment, template: true)
    create(:inpayment, accounting_period_id: accounting_period.id + 1)
    create(:outpayment, accounting_period_id: accounting_period.id, amount: 1000)
    create(:outpayment, accounting_period_id: accounting_period.id, amount: 100.33)
    create(:outpayment, accounting_period_id: accounting_period.id, amount: 30, expected: true)
    create(:outpayment, accounting_period_id: accounting_period.id, amount: 15.50, expected: true)
    create(:outpayment, accounting_period_id: accounting_period.id + 1)
    create(:outpayment, template: true)
    create(:receivable, amount: 20)
    create(:receivable, amount: 25.50)
    create(:receivable, amount: 30, expected: true)
    create(:receivable, amount: 10, expected: true)
    create(:receivable, template: true)
  end

  subject { BalanceReport.new(accounting_period) }

  it 'should return BalanceReport for AccountingPeriod of given id' do
    transactions

    expect(subject.accounting_period).to eq accounting_period
    expect(subject.incomes).to eq 5145
    expect(subject.total_expected_incomes).to eq 5283.45
    expect(subject.expenses).to eq 819.99
    expect(subject.total_expected_expenses).to eq 878.36
    expect(subject.inpayments).to eq 275.25
    expect(subject.total_expected_inpayments).to eq 425.25
    expect(subject.outpayments).to eq 1100.33
    expect(subject.total_expected_outpayments).to eq 1145.83
    expect(subject.receivables).to eq 45.50
    expect(subject.total_expected_receivables).to eq 85.50
    expect(subject.balance).to eq 4325.01
    expect(subject.total_expected_balance).to eq 4405.09
    expect(subject.credit).to eq 7457.99
    expect(subject.total_expected_credit).to eq 7602.57
    expect(subject.credit_including_receivables).to eq 7503.49
    expect(subject.total_expected_credit_including_receivables).to eq 7688.07
    # expect(subject.total_expected_credit_including_receivables).to eq 7648.07
  end

end