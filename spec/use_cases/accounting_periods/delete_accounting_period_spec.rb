describe DeleteAccountingPeriod do

  let(:accounting_period) { create(:accounting_period) }

  subject { DeleteAccountingPeriod.new accounting_period.id }

  it 'should delete AccountingPeriod of given id' do
    subject.run
    expect(AccountingPeriodRepository.count).to eq 0
  end

  it 'should delete all associated transactions' do
    transactions = [
        create(:expense, accounting_period_id: accounting_period.id),
        create(:income, accounting_period_id: accounting_period.id),
        create(:expense, accounting_period_id: accounting_period.id + 1),
    ]
    expect { subject.run }.to change { TransactionRepository.count }.from(3).to(1)
    expect(TransactionRepository.all).to eq [transactions.last]
  end
end