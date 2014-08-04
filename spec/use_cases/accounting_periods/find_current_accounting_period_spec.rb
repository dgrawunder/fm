describe FindCurrentAccountingPeriod do

  let(:current_accounting_period) { create(:accounting_period) }

  it 'should return current AccountingPeriod' do
    create(:current_accounting_period_id_property, value: current_accounting_period.id)
    expect(subject.run).to eq current_accounting_period
  end

  it 'should throw RecordNotFoundError of no current AccountingPeriod exists' do
    expect { subject.run }.to raise_error RecordNotFoundError
  end
end