describe DateUtil do

  subject { DateUtil }

  describe '#find_date' do

    it 'should return next possible date greater or equal given minimum for given day_of_month' do
      min = Date.new(2014, 6, 29)
      max = Date.new(2014, 7, 29)
      expect(subject.find_date(min, max, 1)).to eq Date.new(2014, 7, 1)
      expect(subject.find_date(min, max, 29)).to eq Date.new(2014, 6, 29)
      expect(subject.find_date(min, max, 30)).to eq Date.new(2014, 6, 30)
    end

    context 'if day_of_month is not a valid day in given interval' do

      it 'should return the next possible day' do
        expect(subject.find_date(Date.new(2014, 6, 29), Date.new(2014, 7, 29), 31)).to eq Date.new(2014, 7, 1)
      end
    end

    context 'if day_of_month is outside the interval' do

      it 'should return max date' do
        max = Date.new(2014, 7, 29)
        expect(subject.find_date(Date.new(2014, 7, 1), max, 31)).to eq Date.new(2014, 7, 29)
      end
    end
  end

  describe '#parse_date' do

    context 'value is kind of Date' do

      it 'should return nil' do
        date = Date.current
        expect(subject.parse_date(date)).to be_nil
      end
    end

    context 'value contains only day' do

      it 'should return date with current month and year' do
        expect(subject.parse_date('10')).to eq Date.new(Date.today.year, Date.today.month, 10)
      end
    end

    context 'value contains only day and month' do

      it 'should return date with current month and year' do
        expect(subject.parse_date('10.07')).to eq Date.new(Date.today.year, 7, 10)
      end
    end

    context 'value contains day, month and year' do

      it 'should return date with current month and year' do
        expect(subject.parse_date('10.07.2012')).to eq Date.new(2012, 7, 10)
      end
    end

    context 'value is contains no proper value' do

      it 'should return nil' do
        expect(subject.parse_date('AA')).to be_nil
      end
    end

    context 'value is blank' do

      it 'should return nil' do
        expect(subject.parse_date('')).to be_nil
      end
    end
  end
end