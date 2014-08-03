describe SetCurrentAccountingPeriod do

  let(:accounting_period) { create(:accounting_period) }
  subject { SetCurrentAccountingPeriod.new(accounting_period.id) }

  it 'should set AccountingPeriod of given id as current' do
    subject.run
    expect(PropertyRepository.find_current_accounting_period_id.to_i).to eq accounting_period.id
  end

  it 'should raise RecordNotFoundError if AccountingPeriod of given id does not exists' do
    subject = SetCurrentAccountingPeriod.new(accounting_period.id + 1)
    expect { subject.run }.to raise_error RecordNotFoundError
  end
end