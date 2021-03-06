describe UpdateCategory do

  let(:category) do
    create(:expense_category, name: 'Category 1')
  end

  let(:form) { CategoryForm.new name: 'Category 2', transaction_type: 'income' }

  subject { UpdateCategory.new(category.id, form) }

  it 'should update Category' do

    actual_category = subject.run

    expect(actual_category).to be_instance_of Category
    expect(actual_category.name).to eq form.name

    stored_category = CategoryRepository.find(category.id)
    expect(stored_category.transaction_type).to eq TransactionType[:income]
  end

  it 'should throw ValidationError when given form is invalid' do
    form.name = nil
    expect { subject.run }.to raise_error ValidationError

    expect(CategoryRepository.find(category.id).name).to eq category.name
  end
end