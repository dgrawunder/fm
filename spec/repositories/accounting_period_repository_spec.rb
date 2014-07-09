describe AccountingPeriodRepository do

  subject { AccountingPeriodRepository }

  describe '#exists_by_name?' do

    context 'when AccountingPeriod with given name exists' do

      it 'should return true' do
        create(:accounting_period, name: 'Period 1')
        expect(subject.exists_by_name?('Period 1')).to be_true
      end
    end

    context 'when AccountingPeriod with given name does not exist' do

      it 'should return false' do
        create(:accounting_period, name: 'Period 1')
        expect(subject.exists_by_name?('Period 2')).to be_false
      end
    end
  end
end