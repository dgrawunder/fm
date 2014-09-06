describe TransactionSearchForm do

  describe '#accounting_period_name=' do

    let(:accounting_periods) do
      [
          create(:accounting_period, name: 'First Accounting Period'),
          create(:accounting_period, name: 'Second Accounting Period')
      ]
    end

    it 'should set accounting_period_id' do
      accounting_periods
      subject.accounting_period_name = 'First'
      expect(subject.accounting_period_id).to eq accounting_periods.first.id
    end

    it 'should throw UnknownAccountingPeriodError if no AccountingPeriod could be found' do
      expect {
        subject.accounting_period_name = 'First'
      }.to raise_error(UnknownAccountingPeriodError)
    end
  end
end