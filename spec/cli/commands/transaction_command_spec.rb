require 'cli_spec_helper'

describe FmCli::Transaction, type: :cli do

  let(:accounting_period_1) { create(:accounting_period, name: 'First Accounting Period') }
  let(:current_accounting_period) { create(:accounting_period, name: 'Second Accounting Period') }
  let(:category) { create(:income_category, name: 'Category 1') }

  before :each do
    accounting_period_1
    current_accounting_period
    create(:current_accounting_period_id_property, value: current_accounting_period.id)
  end

  describe 'add' do

    it 'should create transaction belonging to given AccountingPeriod and Category' do
      category
      expect_to_print_success_message
      expect_to_print :transaction

      run_command 'add',
                  'description', '23.5',
                  '-p', 'First ', '-c', 'Category 1', '-t', 'income'
      expect(TransactionRepository.count).to eq 1

      actual_transaction = TransactionRepository.first
      expect(actual_transaction.accounting_period).to eq accounting_period_1
      expect(actual_transaction.category).to eq category
    end

    it 'should create transaction belong to current AccountingPeriod if no one given' do

      run_command 'add',
                  'description', '23.5',
                  '-p', 'Second', '-t', 'income'
      expect(TransactionRepository.count).to eq 1
      expect(TransactionRepository.first.accounting_period).to eq current_accounting_period
    end

    it 'should print error on invalid input' do
      expect_to_print_failure_message
      expect_to_print_errors

      run_command 'add',
                  '-p', 'First Accounting Period',
                  '-D', 'description'

      expect(TransactionRepository.count).to eq 0
    end
  end

  describe 'update' do

    let(:transaction) { create(:expense, description: 'desc 1', accounting_period_id: create(:accounting_period).id) }

    it 'should update category' do

      expect_to_print_success_message
      expect_to_print :transaction

      run_command 'update', transaction.id.to_s, '-D', 'desc 2'
      expect(TransactionRepository.first.description).to eq 'desc 2'
    end

    it 'should print error on invalid input' do
      expect_to_print_failure_message
      expect_to_print_errors

      run_command 'update', transaction.id.to_s, '-D', ''
      expect(TransactionRepository.first.description).to eq 'desc 1'
    end

    it 'should print error on invalid id' do
      expect_to_print_failure_message

      run_command 'update', (transaction.id + 1).to_s, '-D', 'desc 2'
    end
  end

  describe 'delete' do

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

  describe 'list transactions commands' do

    let(:transactions) do
      [
          create(:expense, accounting_period_id: current_accounting_period.id, date: 2.days.ago),
          create(:expense, accounting_period_id: current_accounting_period.id, date: 1.days.ago),
          create(:expense, accounting_period_id: accounting_period_1.id, date: 2.days.ago),
          create(:expense, accounting_period_id: accounting_period_1.id, date: 1.days.ago),
          create(:income, accounting_period_id: current_accounting_period.id),
          create(:income, accounting_period_id: current_accounting_period.id),
          create(:expense, day_of_month: 1, template: true),
          create(:expense, day_of_month: 2, template: true)
      ]
    end

    before :each do
      transactions
    end

    it 'should print all current transactions of given type' do
      expect_to_print :transactions do |actual_transactions|
        expect(actual_transactions).to eq [transactions.second, transactions.first]
      end
      run_command 'expenses'
    end

    context 'if option -p is given' do

      it 'should print all transactions of given type and specified AccountingPeriod' do
        expect_to_print :transactions do |actual_transactions|
          expect(actual_transactions).to eq [transactions.fourth, transactions.third]
        end
        run_command 'expenses', '-p', 'First'
      end

      it 'should print failure message if specified AccountingPeriod could not be found' do
        expect_to_print_failure_message
        run_command 'expenses', '-p', 'foo'
      end
    end

    context 'if options -T is given' do

      it 'should print all templates of given type' do
        expect_to_print :transactions do |actual_transactions|
          expect(actual_transactions).to eq [transactions[7], transactions[6]]
        end
        run_command 'expenses', '-T'
      end
    end
  end

  describe 'search' do

    let(:transactions) do
      [
          create(:transaction, accounting_period_id: current_accounting_period.id, description: 'Food 1', date: 1.day.ago),
          create(:transaction, accounting_period_id: current_accounting_period.id, description: 'Food 2', date: 2.days.ago),
          create(:transaction, accounting_period_id: current_accounting_period.id, description: 'foo'),
          create(:transaction, accounting_period_id: current_accounting_period.id+1, description: 'Food 1')
      ]
    end

    before :each do
      transactions
    end

    it 'should search for current transactions' do
      expect_to_print :transactions do |actual_transactions|
        expect(actual_transactions).to eq [transactions.first, transactions.second]
      end
      run_command 'search', 'Food'
    end
  end

  describe 'payed' do

    let(:transaction) { create(:transaction, expected: true, accounting_period_id: accounting_period_1.id) }

    it 'should set expected to false' do
      expect_to_print_success_message
      run_command 'payed', transaction.id.to_s
      expect(TransactionRepository.find(transaction.id)).to_not be_expected
    end
  end
end
