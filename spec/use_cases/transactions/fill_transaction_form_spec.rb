describe FillTransactionForm do

  let(:transaction) { create(:transaction) }

  subject { FillTransactionForm.new transaction.id }

  it 'should return filled CategoryForm' do

    actual_form = subject.run

    expect(actual_form).to be_instance_of TransactionForm
    expect(actual_form.amount).to eq transaction.amount
    expect(actual_form.description).to eq transaction.description
    expect(actual_form.type).to eq transaction.type
  end
end