describe DeleteAccountingPeriod do

  let(:accounting_period) { create(:accounting_period) }

  subject { DeleteAccountingPeriod.new accounting_period.id }

  it 'should delete AccountingPeriod of given id' do
    subject.run
    expect(AccountingPeriodRepository.count).to eq 0
  end
end