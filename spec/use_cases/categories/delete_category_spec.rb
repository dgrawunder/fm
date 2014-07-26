describe DeleteCategory do

  let(:category) { create(:category) }

  subject { DeleteCategory.new category.id }

  it 'should delete category of given id and nullify associated transactions' do
    transaction = create(:transaction, category_id: category.id)

    subject.run
    expect(CategoryRepository.count).to eq 0
    expect(TransactionRepository.find(transaction.id).category_id).to be_nil
  end
end