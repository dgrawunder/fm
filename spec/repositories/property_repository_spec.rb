describe PropertyRepository do

  subject { PropertyRepository }
  
  describe '::find_value' do

    it 'should find value for given key when key exists' do
      create(:property, key: 'key 1', value: 'value 1')
      create(:property, key: 'key 2', value: 'value 2')

      expect(subject.find_value('key 1')).to eq 'value 1'
    end

    it 'should return nil when key not exists' do
      expect(subject.find_value('key 1')).to be_nil
    end
  end

  # describe '::save_value' do
  #
  #   it 'should create Property for given key when key not exists' do
  #     actual_property = subject.save_value('key 1', 'value 1')
  #
  #     expect(actual_property).to be_instance_of Property
  #   end
  # end
end