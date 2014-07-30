require 'cli_spec_helper'

describe FmCli::Category, type: :cli do

  describe '#add' do

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

  describe '#list' do

    it 'should list categories' do
      categories = [
          create(:expense_category, name: 'Cat 2'),
          create(:expense_category, name: 'Cat 1'),
          create(:income_category, name: 'Cat 3')
      ]
      expect_to_print :categories do |actual_categories|
        expect(actual_categories).to eq [categories.second, categories.first]
      end
      run_command 'category', 'list', '-t', 'exp'
    end

    it 'should print failure message if transaction_type is invalid' do
      expect_to_print_failure_message
      run_command 'category', 'list', '-t', 'foo'
    end
  end

  describe '#update' do

    let(:category) { create(:category, name: 'Cat 1') }

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

  describe '#delete' do

    let(:category) { create(:category) }

    it 'should delete Category when confirmed' do
      expect_to_ask_yes_question answer: 'yes'
      expect_to_print_success_message

      run_command 'category', 'delete', category.id.to_s
      expect(CategoryRepository.count).to eq 0
    end

    it 'should not delete Category when not confirmed' do
      expect_to_ask_yes_question answer: 'no'

      run_command 'category', 'delete', category.id.to_s
      expect(CategoryRepository.count).to eq 1
    end

    it 'should print error on invalid id' do
      expect_to_print_failure_message

      run_command 'category', 'delete', (category.id + 1).to_s
    end
  end
end
