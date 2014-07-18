describe DeleteCategory do

  let(:category) { create(:category) }

  subject { DeleteCategory.new category.id }

  it 'should delete category of given id' do
    subject.run
    expect(CategoryRepository.count).to eq 0
  end
end