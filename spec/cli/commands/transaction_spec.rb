require 'cli_spec_helper'

describe FmCli::Transaction, type: :cli do

  let(:accounting_period_1) { create(:accounting_period, name: 'Accounting Period 1') }
  let(:accounting_period_2) { create(:accounting_period, name: 'Accounting Period 2') }
  let(:category) { create(:income_category, name: 'Category 1') }

  before :each do
    accounting_period_1
    accounting_period_2
    category
    create(:current_accounting_period_id_property, value: accounting_period_2.id)
  end

  describe '#add' do

    it 'should create transaction belonging to given AccountingPeriod and Category' do
      expect_to_print_success_message
      expect_to_print :transaction

      run_command 'add',
                  '-p', 'Accounting Period 1', '-c', 'Category 1',
                  '-d', 'description', '-a', '23.5', '-t', 'income'
      expect(TransactionRepository.count).to eq 1

      actual_transaction = TransactionRepository.first
      expect(actual_transaction.accounting_period).to eq accounting_period_1
      expect(actual_transaction.category).to eq category
    end

    it 'should print error on invalid input' do
      expect_to_print_failure_message
      expect_to_print_errors

      run_command 'add',
                  '-p', 'Accounting Period 1', '-c', 'category 1',
                  '-d', 'description'

      expect(TransactionRepository.count).to eq 0
    end
  end

  describe '#update' do

    let(:transaction) { create(:expense, description: 'desc 1', accounting_period_id: create(:accounting_period).id) }

    it 'should update category' do

      expect_to_print_success_message
      expect_to_print :transaction

      run_command 'update', transaction.id.to_s, '-d', 'desc 2'
      expect(TransactionRepository.first.description).to eq 'desc 2'
    end

    it 'should print error on invalid input' do
      expect_to_print_failure_message
      expect_to_print_errors

      run_command 'update', transaction.id.to_s, '-d', ''
      expect(TransactionRepository.first.description).to eq 'desc 1'
    end

    it 'should print error on invalid id' do
      expect_to_print_failure_message

      run_command 'update', (transaction.id + 1).to_s, '-d', 'desc 2'
    end
  end

  describe '#delete' do

    let(:transaction) { create(:expense) }

    it 'should delete Transaction when confirmed' do
      expect_to_ask_yes_question answer: 'yes'
      expect_to_print_success_message

      run_command 'delete', transaction.id.to_s
      expect(TransactionRepository.count).to eq 0
    end

    it 'should not delete Transaction when not confirmed' do
      expect_to_ask_yes_question answer: 'no'

      run_command 'delete', transaction.id.to_s
      expect(TransactionRepository.count).to eq 1
    end

    it 'should print error on invalid id' do
      expect_to_print_failure_message

      run_command 'delete', (transaction.id + 1).to_s
    end
  end
end
