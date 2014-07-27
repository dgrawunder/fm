describe FindAccountingPeriod do

  let(:accounting_period) { create(:accounting_period) }

  subject { FindAccountingPeriod.new accounting_period.id }

  it 'should find Category of given id' do
    expect(subject.run).to eq accounting_period
  end
end