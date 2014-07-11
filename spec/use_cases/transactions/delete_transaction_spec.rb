describe DeleteTransaction do

  let(:transaction) { create(:transaction) }

  subject { DeleteTransaction.new transaction.id }

  it 'should delete Transaction of given id' do
    subject.run!
    expect(TransactionRepository.count).to eq 0
  end
end