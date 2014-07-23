require 'cli_spec_helper'

describe FmCli::Category, type: :cli do

  describe '#create' do

    it 'should create category' do
      expect_to_print_success_message
      expect_to_print :category

      run_command 'category', 'add', 'category 1', '-t', 'income'
      actual_category = CategoryRepository.first
      expect(actual_category.name).to eq 'category 1'
      expect(actual_category.transaction_type).to eq TransactionType[:income]
    end
  end
end