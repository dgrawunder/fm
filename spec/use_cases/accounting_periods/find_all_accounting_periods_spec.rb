describe FindAllAccountingPeriods do

  let(:accounting_periods) do
    [
        create(:accounting_period, starts_at: 3.days.ago),
        create(:accounting_period, starts_at: 1.day.ago),
        create(:accounting_period, starts_at: 2.days.ago)
    ]
  end

  before :each do
    accounting_periods
  end

  it 'should return all AccountingPeriods ordered by strats_at desc' do
      expect(subject.run).to eq [accounting_periods.second, accounting_periods.third, accounting_periods.first]
  end
end