describe AccountingPeriodForm do

  it { should validate_presence_of :name }
  it { should ensure_length_of(:name).is_at_most(32) }
  it { should validate_presence_of :starts_at }
  it { should validate_presence_of :ends_at }
  it { should validate_presence_of :initial_deposit }


  it 'should ensure that name is unique' do
    subject.name = 'Period 1'
    expect(AccountingPeriodRepository).to receive(:exists_by_name?).
                                              with(subject.name).and_return(true)

    expect(subject.valid?).to be_false
    expect(subject.errors[:name]).to include I18n.t('errors.messages.taken')
  end

  describe '#stats_at' do

    it 'should have default value of current date' do
      current_date = Date.new(2014, 02, 12)
      allow(Date).to receive(:today).and_return(current_date)
      expect(subject.starts_at).to eq current_date
    end
  end

  describe '#stats_at' do

    it 'should have default value of current date + 30 days' do
      current_date = Date.new(2014, 02, 12)
      allow(Date).to receive(:today).and_return(current_date)
      expect(subject.ends_at).to eq current_date + 30.days
    end
  end

  describe '#initial_deposit' do

    it 'should have default value of 0' do
      expect(subject.initial_deposit).to eq BigDecimal.new(0)
    end
  end

end