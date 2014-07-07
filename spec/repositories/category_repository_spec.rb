describe CategoryRepository do

  subject { CategoryRepository }

  describe '#exists_by_name_and_transaction_type?' do

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