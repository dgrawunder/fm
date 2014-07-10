describe DateParser do

  subject { DateParser }

  context 'value is kind of Date' do

    it 'should return nil' do
      date = Date.current
      expect(subject.parse(date)).to be_nil
    end
  end

  context 'value contains only day' do

    it 'should return date with current month and year' do
      expect(subject.parse('10')).to eq Date.new(Date.today.year, Date.today.month, 10)
    end
  end

  context 'value contains only day and month' do

    it 'should return date with current month and year' do
      expect(subject.parse('10.07')).to eq Date.new(Date.today.year, 7, 10)
    end
  end

  context 'value contains day, month and year' do

    it 'should return date with current month and year' do
      expect(subject.parse('10.07.2012')).to eq Date.new(2012, 7, 10)
    end
  end

  context 'value is contains no proper value' do

    it 'should return nil' do
      expect(subject.parse('AA')).to be_nil
    end
  end

  context 'value is blank' do

    it 'should return nil' do
      expect(subject.parse('')).to be_nil
    end
  end
end