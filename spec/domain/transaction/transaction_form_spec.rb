describe TransactionForm do

  it { should validate_presence_of :description }
  it { should ensure_length_of(:description).is_at_most(48) }
  it { should validate_presence_of :category_id }

  it 'should ensure that Category with given id exists for given transaction_type' do
    subject.category_id = 5
    subject.type = TransactionType[:expense]
    expect(CategoryRepository).to receive(:exists_by_name_name_and_transaction_type?).
                                      with(subject.category_id, subject.type).and_return(false)
    subject.valid?
    expect(subject.errors[:category_id]).to include "doesn't exists"
  end

  describe '#date=' do

    it 'should parse to date' do
      subject.date = '23.05'
      expect(subject.date).to eq Date.new(Time.now.year, 5, 23)
    end
  end

  describe '#category_id=' do

    it 'should try to find proper Category when string value given' do
      subject.type = TransactionType[:expense]
      expect(CategoryRepository).to receive(:id_by_name_and_transaction_type).
                                        with('Cate 7', subject.type).and_return(3)
      subject.category_id = 'Cate 7'
      expect(subject.category_id).to eq 3
    end
  end

  describe '#expected' do

    it 'should have default value' do
      expect(subject.expected).to be_false
    end
  end

  describe '#type' do

    it 'should have default value' do
      expect(subject.type).to eq TransactionType[:expense]
    end
  end
end