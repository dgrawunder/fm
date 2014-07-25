describe FindCategory do

  let(:category) { create(:expense_category) }

  subject { FindCategory.new category.id }

  it 'should find Category of given id' do
    expect(subject.run).to eq category
  end
end