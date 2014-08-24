describe DateFinder do

  subject { DateFinder }

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
end