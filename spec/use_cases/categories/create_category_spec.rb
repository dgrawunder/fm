describe CreateCategory do

  let(:form) { CategoryForm.new name: 'Category 1', transaction_type: 'expense' }

  subject { CreateCategory.new(form) }

  it 'should create Category' do
    actual_category = subject.run!

    expect(actual_category).to be_instance_of Category

    persisted_category = CategoryRepository.find(actual_category.id)
    expect(persisted_category.name).to eq form.name
    expect(persisted_category.transaction_type).to eq TransactionType[:expense]
  end

  it 'should throw ValidationError when given form is invalid' do
    form.name = nil
    expect { subject.run! }.to raise_error ValidationError
    expect(CategoryRepository.count).to eq 0
  end
end