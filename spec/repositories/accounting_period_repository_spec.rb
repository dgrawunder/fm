describe AccountingPeriodRepository do

  subject { AccountingPeriodRepository }

  describe '::exists_by_id?' do

    it 'should return true when AccountingPeriod with given id exists' do
      accounting_period = create(:accounting_period)
      expect(subject.exists_by_id?(accounting_period.id)).to be true
    end

    it 'should return false when AccountingPeriod with given id does not exist' do
      accounting_period = create(:accounting_period)
      expect(subject.exists_by_id?(accounting_period.id + 1)).to be false
    end
  end

  describe '::exists_by_name?' do

    it 'should return true when AccountingPeriod with given name exists' do
      create(:accounting_period, name: 'Period 1')
      expect(subject.exists_by_name?('Period 1')).to be true
    end

    it 'should return false when AccountingPeriod with given name does not exist' do
      create(:accounting_period, name: 'Period 1')
      expect(subject.exists_by_name?('Period 2')).to be false
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

    it 'should return nil when search is nil' do
      create(:accounting_period, name: 'AccountingPeriod 1')
      expect(subject.search_id_by_name(nil)).to be_nil
    end
  end

  describe '::all_ordered_by_starts_at' do

    it 'should return all ordered by starts_at desc' do
      accounting_period_3 = create(:accounting_period, starts_at: 3.days.ago)
      accounting_period_1 = create(:accounting_period, starts_at: 1.day.ago)
      accounting_period_2 = create(:accounting_period, starts_at: 2.days.ago)

      expect(subject.all_ordered_by_starts_at_desc).to eq [accounting_period_1, accounting_period_2, accounting_period_3]
    end
  end
end