describe AccountingPeriodForm do

  it { should validate_presence_of :name }
  it { should ensure_length_of(:name).is_at_most(32) }
  it { should validate_presence_of :starts_at }
  it { should validate_presence_of :ends_at }
  it { should validate_presence_of :initial_deposit }

  describe '#initial_deposit' do

    it 'should have default value' do
      expect(subject.initial_deposit).to eq BigDecimal.new(0)
    end
  end

end