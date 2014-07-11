describe AccountingPeriodRepository do

  subject { AccountingPeriodRepository }

  describe '#exists_by_id?' do

    it 'should return true when AccountingPeriod with given id exists' do
      accounting_period = create(:accounting_period)
      expect(subject.exists_by_id?(accounting_period.id)).to be_true
    end

    it 'should return false when AccountingPeriod with given id does not exist' do
      accounting_period = create(:accounting_period)
      expect(subject.exists_by_id?(accounting_period.id + 1)).to be_false
    end
  end

  describe '#exists_by_name?' do

    it 'should return true when AccountingPeriod with given name exists' do
      create(:accounting_period, name: 'Period 1')
      expect(subject.exists_by_name?('Period 1')).to be_true
    end

    it 'should return false when AccountingPeriod with given name does not exist' do
      create(:accounting_period, name: 'Period 1')
      expect(subject.exists_by_name?('Period 2')).to be_false
    end
  end

  describe '::search_id_by_name' do

    it 'should return id when AccountingPeriods with given name could be found' do
      expected_accounting_period = create(:accounting_period, name: 'AccountingPeriod 1')
      create(:accounting_period, name: 'AccountingPeriod 2')
      expect(subject.search_id_by_name('riod 1')).to eq expected_accounting_period.id
    end

    it 'should return nil when no AccountingPeriod could be found' do
      expect(subject.search_id_by_name('riod 1')).to be_nil
    end
  end
end