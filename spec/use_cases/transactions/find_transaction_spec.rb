describe FindTransaction do

  let(:transaction) { create(:expense) }

  subject { FindTransaction.new transaction.id }

  it 'should find Transaction of given id' do
    expect(subject.run).to eq transaction
  end
end