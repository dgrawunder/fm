describe TransactionType do

  subject { TransactionType }

  describe '::find_name' do

    it 'should return name for given number' do
      expect(subject.find_name(4)).to eq :inpayment
    end

    it 'should return nil if no name found' do
      expect(subject.find_name(1000)).to be_nil
    end
  end

  describe '::find_number' do


    it 'should return the number of the most matching Transaction-Type from the beginning of the word' do
      expect(subject.find_number('e')).to eq TransactionType[:expense]
      expect(subject.find_number('expe')).to eq TransactionType[:expense]
      expect(subject.find_number('inp')).to eq TransactionType[:inpayment]
      expect(subject.find_number('outpayment')).to eq TransactionType[:outpayment]
    end

    it 'should return nil when no match found' do
      expect(subject.find_number('none')).to be_nil
      expect(subject.find_number('xpe')).to be_nil
    end

    it 'should return nil when nil given' do
      expect(subject.find_number(nil)).to be_nil
    end
  end
end