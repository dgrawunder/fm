describe CategoryRepository do

  subject { CategoryRepository }

  describe '::exists_by_id_and_transaction_type?' do

    it 'should return true when Categories with given id and transaction_type exists' do
      category = create(:expense_category)
      expect(subject.exists_by_id_and_transaction_type?(category.id, TransactionType[:expense])).to be_true
    end

    it 'should return false when Category with given id does not exist' do
      category = create(:expense_category)
      expect(subject.exists_by_id_and_transaction_type?(category.id + 1, TransactionType[:expense])).to be_false
    end

    it 'should return false when Category with given transaction_type does not exist' do
      category = create(:expense_category)
      expect(subject.exists_by_id_and_transaction_type?(category.id, TransactionType[:income])).to be_false
    end
  end


  describe '::exists_by_name_and_transaction_type?' do

    it 'should return true when Categories with given name and transaction_type exists' do
      category = create(:expense_category, name: 'Category 1')
      expect(subject.exists_by_name_and_transaction_type?(category.name, TransactionType[:expense])).to be_true
    end

    it 'should return false when Category with given name does not exist' do
      category = create(:expense_category, name: 'Category 2')
      expect(subject.exists_by_name_and_transaction_type?(category.name + 'new', TransactionType[:expense])).to be_false
    end

    it 'should return false when Category with given transaction_type does not exist' do
      category = create(:expense_category, name: 'Category 1')
      expect(subject.exists_by_name_and_transaction_type?(category.name, TransactionType[:income])).to be_false
    end
  end

  describe '::search_id_by_name_and_transaction_type' do

    context 'when Categories with given substring name and transaction_type exists' do

      it 'should return first id' do
        expected_category = create(:expense_category, name: 'Category 1')
        create(:expense_category, name: 'Category 2')
        create(:expense_category, name: 'Category 3')
        create(:income_category, name: 'Category 1')

        expect(subject.search_id_by_name_and_transaction_type('gory 1', TransactionType[:expense])).to eq expected_category.id
      end
    end

    context 'when Category with given substring name does not exist' do

      it 'should return nil' do
        create(:expense_category, name: 'Category 1')
        expect(subject.search_id_by_name_and_transaction_type('gory 2', TransactionType[:expense])).to be_nil
      end
    end

    context 'when Category with given transaction_type does not exist' do

      it 'should return nil' do
        create(:expense_category, name: 'Category 1')
        expect(subject.search_id_by_name_and_transaction_type('gory 1', TransactionType[:income])).to be_nil
      end
    end
  end
end