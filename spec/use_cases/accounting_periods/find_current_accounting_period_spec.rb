describe FindCurrentAccountingPeriod do

  let(:current_accounting_period) { create(:accounting_period) }

  before :each do
    create(:current_accounting_period_id_property, key: current_accounting_period.id)
  end

  # it 'should return current AccountingPeriod' do
  #   expect(subject.run).to eq current_accounting_period
  # end
end