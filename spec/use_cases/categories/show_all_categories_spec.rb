describe ShowAllCategories do

  let(:categories) {
    [
        create(:expense_category, name: 'Cat 3'),
        create(:income_category, name: 'Cat 4'),
        create(:expense_category, name: 'Cat 1'),
        create(:expense_category, name: 'Cat 2'),
    ]
  }

  subject { ShowAllCategories.new }

  before :each do
    categories
  end

  it 'should return all categories sorted by name' do
    expect(subject.run).to eq [categories.third, categories.fourth, categories.first, categories.second]
  end

  it 'should return only of certain TransactionType if transaction_type_name given' do
    subject = ShowAllCategories.new('exp')
    expect(subject.run).to eq [categories.third, categories.fourth, categories.first]
  end

  it 'should throw UnknownTransactionType if invalid transaction_type_name given' do
    subject = ShowAllCategories.new('foo')
    expect { subject.run }.to raise_error UnknownTransactionTypeError
  end
end