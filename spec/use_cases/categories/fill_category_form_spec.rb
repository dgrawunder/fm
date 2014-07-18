describe FillCategoryForm do

  let(:category) { create(:category) }

  subject { FillCategoryForm.new category.id }

  it 'should return filled CategoryForm' do

    actual_form = subject.run

    expect(actual_form).to be_instance_of CategoryForm
    expect(actual_form.name).to eq category.name
    expect(actual_form.transaction_type).to eq category.transaction_type
  end

end