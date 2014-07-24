require 'cli_spec_helper'

describe FmCli::Category, type: :cli do

  describe '#create' do

    it 'should create category' do
      expect_to_print_success_message
      expect_to_print :category

      run_command 'category', 'add', 'category 1', '-t', 'income'
      expect(CategoryRepository.count).to eq 1
    end

    it 'should print error on invalid input' do
      expect_to_print_failure_message
      expect_to_print_errors

      run_command 'category', 'add', 'category 1', '-t', 'foo'
      expect(CategoryRepository.count).to eq 0
    end
  end

  describe '#update' do

    let(:category) { create(:category, name: 'Cat 1') }

    before :each do
      category
    end

    it 'should update category' do

      expect_to_print_success_message
      expect_to_print :category

      run_command 'category', 'update', category.id.to_s, '-n', 'Cat 2'
      expect(CategoryRepository.first.name).to eq 'Cat 2'
    end

    it 'should print error on invalid input' do
      expect_to_print_failure_message
      expect_to_print_errors

      run_command 'category', 'update', category.id.to_s, '-t', 'foo'
      expect(CategoryRepository.first.name).to eq 'Cat 1'
    end

    it 'should print error on invalid id' do
      expect_to_print_failure_message

      run_command 'category', 'update', (category.id + 1).to_s, '-t', 'foo'
    end
  end
end