describe CategoryForm do

  it { should validate_presence_of :name }
  it { should ensure_length_of(:name).is_at_most(32) }
  it { should ensure_inclusion_of(:transaction_type).in_array(TransactionType.numbers) }

  it 'should ensure that name is unique for given TransactionType on new' do
    subject.name = 'Cate 1'
    subject.transaction_type = TransactionType[:income]
    expect(CategoryRepository).to(
        receive(:exists?).with(name: subject.name, transaction_type: subject.transaction_type).and_return(true))

    expect(subject.valid?).to be_false
    expect(subject.errors[:name]).to include I18n.t('errors.messages.taken')
  end

  it 'should ensure that name is unique for given TransactionType except for the own id on update' do
    subject.entity_id = 7
    subject.name = 'Cate 1'
    subject.transaction_type = TransactionType[:income]
    expect(CategoryRepository).to receive(:exists?).
            with(id: subject.entity_id,
                 name: subject.name,
                 transaction_type: subject.transaction_type).and_return(true)

    expect(subject.valid?).to be_false
    expect(subject.errors[:name]).to include I18n.t('errors.messages.taken')
  end

  it 'should ensure that no associated Transaction exists when transaction-type changes' do
    subject.entity_id = 3
    expect(TransactionRepository).to receive(:exists?).with(category_id: 3).and_return(true)
    expect(subject.valid?).to be_false
    expect(subject.errors[:transaction_type]).not_to be_empty
  end


  describe '#transaction_type' do

    it 'should have default value' do
      expect(subject.transaction_type).to eq TransactionType[:expense]
    end
  end

  describe '#transaction_type=' do

    it 'should cast argument to number' do
      subject.transaction_type = 'incom'
      expect(subject.transaction_type).to eq TransactionType[:income]
    end
  end
end