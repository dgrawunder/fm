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
    create(:outpayment, receivable: true, repaid: false, accounting_period_id: accounting_period.id, amount: 20)
    create(:outpayment, receivable: true, repaid: false, accounting_period_id: accounting_period.id, amount: 26.50)
    create(:outpayment, receivable: true, repaid: true, accounting_period_id: accounting_period.id, amount: 13)
    create(:outpayment, receivable: true, repaid: false, accounting_period_id: accounting_period.id, amount: 30, expected: true)
    create(:outpayment, receivable: true, repaid: false, accounting_period_id: accounting_period.id, amount: 10, expected: true)
    create(:outpayment, receivable: true, repaid: true, accounting_period_id: accounting_period.id, amount: 11, expected: true)
    create(:outpayment, receivable: true, repaid: false, amount: 25)
    create(:outpayment, receivable: true, repaid: false, template: true)
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
    expect(subject.outpayments).to eq 1159.83
    expect(subject.total_expected_outpayments).to eq 1256.33
    expect(subject.open_receivables).to eq 46.50
    expect(subject.total_expected_open_receivables).to eq 86.50
    expect(subject.balance).to eq 4325.01
    expect(subject.total_expected_balance).to eq 4405.09
    expect(subject.credit).to eq 7443.99
    expect(subject.total_expected_credit).to eq 7577.57
    expect(subject.credit_including_open_receivables).to eq 7490.49
    expect(subject.total_expected_credit_including_total_expected_open_receivables).to eq 7664.07
  end

end