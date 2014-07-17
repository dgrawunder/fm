describe TransactionType do

  describe '::find_number' do

    subject { TransactionType }

    it 'should return the number of the most matching Transaction-Type from the beginning of the word' do
      expect(subject.find_number('e')).to eq TransactionType[:expense]
      expect(subject.find_number('expe')).to eq TransactionType[:expense]
      expect(subject.find_number('inp')).to eq TransactionType[:inpayment]
      expect(subject.find_number('receivable')).to eq TransactionType[:receivable]
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