describe AccountingPeriodForm do

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to ensure_length_of(:name).is_at_most(32) }
  it { is_expected.to validate_presence_of :starts_at }
  it { is_expected.to validate_presence_of :ends_at }
  it { is_expected.to validate_presence_of :initial_deposit }

  it 'should ensure that name is unique' do
    subject.entity_id = 3
    subject.name = 'Period 1'
    expect(AccountingPeriodRepository).to receive(:unique?).
                                              with(3, name: subject.name).and_return(false)

    expect(subject.valid?).to be false
    expect(subject.errors[:name]).to include I18n.t('errors.messages.taken')
  end

  describe '#starts_at' do

    it 'should have default value of current date' do
      current_date = Date.new(2014, 02, 12)
      allow(Date).to receive(:today).and_return(current_date)
      expect(subject.starts_at).to eq current_date
    end
  end

  describe '#starts_at=' do

    it 'should parse to date' do
      subject.starts_at = '23.05'
      expect(subject.starts_at).to eq Date.new(Time.now.year, 5, 23)
    end
  end

  describe '#ends_at' do

    it 'should have default value of current date + 30 days' do
      current_date = Date.new(2014, 02, 12)
      allow(Date).to receive(:today).and_return(current_date)
      expect(subject.ends_at).to eq current_date + 30.days
    end
  end

  describe '#ends_at=' do

    it 'should parse to date' do
      subject.ends_at = '23.05'
      expect(subject.ends_at).to eq Date.new(Time.now.year, 5, 23)
    end
  end

  describe '#initial_deposit' do

    it 'should have default value of 0' do
      expect(subject.initial_deposit).to eq BigDecimal.new(0)
    end
  end

end