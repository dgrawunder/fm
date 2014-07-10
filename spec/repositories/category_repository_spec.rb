describe CategoryRepository do

  subject { CategoryRepository }

  describe '::exists_by_name_name_and_transaction_type?' do

    context 'when Categories with given name and transaction_type exists' do

      it 'should return true' do
        create(:expense_category, name: 'Category 1')

        expect(subject.exists_by_name_name_and_transaction_type?('Category 1', TransactionType[:expense])).to be_true
      end
    end

    context 'when Category with given name does not exist' do

      it 'should return false' do
        create(:expense_category, name: 'Category 2')
        expect(subject.exists_by_name_name_and_transaction_type?('Category 1', TransactionType[:expense])).to be_false
      end
    end

    context 'when Category with given transaction_type does not exist' do

      it 'should return false' do
        create(:expense_category, name: 'Category 1')
        expect(subject.exists_by_name_name_and_transaction_type?('Category 1', TransactionType[:income])).to be_false
      end
    end
  end


  describe '::id_by_name_and_transaction_type' do

    context 'when Categories with given substring name and transaction_type exists' do

      it 'should return first id' do
        expected_category = create(:expense_category, name: 'Category 1')
        create(:expense_category, name: 'Category 2')
        create(:expense_category, name: 'Category 3')
        create(:income_category, name: 'Category 1')

        expect(subject.id_by_name_and_transaction_type('gory 1', TransactionType[:expense])).to eq expected_category.id
      end
    end

    context 'when Category with given substring name does not exist' do

      it 'should return nil' do
        create(:expense_category, name: 'Category 1')
        expect(subject.id_by_name_and_transaction_type('gory 2', TransactionType[:expense])).to be_nil
      end
    end

    context 'when Category with given transaction_type does not exist' do

      it 'should return nil' do
        create(:expense_category, name: 'Category 1')
        expect(subject.id_by_name_and_transaction_type('gory 1', TransactionType[:income])).to be_nil
      end
    end
  end

  describe '::exists_by_name_and_transaction_type?' do

    context 'when transaction exists with given name and type' do

      it 'should return true' do
        create(:income_category, name: 'Cat 1')
        expect(subject.exists_by_name_and_transaction_type?('Cat 1', TransactionType[:income])).to be_true
      end
    end

    context 'when transaction does not with given name and type' do

      it 'should return true' do
        create(:income_category, name: 'Cat 1')
        create(:expense_category, name: 'Cat 2')
        expect(subject.exists_by_name_and_transaction_type?('Cat 2', TransactionType[:income])).to be_false
      end
    end

  end
end