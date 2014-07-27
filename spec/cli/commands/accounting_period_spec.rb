require 'cli_spec_helper'

describe FmCli::AccountingPeriod, type: :cli do

  describe '#add' do

    it 'should create AccountingPeriod' do
      expect_to_print_success_message
      expect_to_print :accounting_period

      run_command 'aperiod', 'add', 'period 1'
      expect(AccountingPeriodRepository.count).to eq 1
    end

    it 'should print error on invalid input' do
      expect_to_print_failure_message
      expect_to_print_errors

      run_command 'aperiod', 'add', ''
      expect(AccountingPeriodRepository.count).to eq 0
    end
  end


  describe '#update' do

    let(:accounting_period) { create(:accounting_period, name: 'Period 1') }

    before :each do
      accounting_period
    end

    it 'should update AccountingPeriod' do

      expect_to_print_success_message
      expect_to_print :accounting_period

      run_command 'aperiod', 'update', accounting_period.id.to_s, '-n', 'Period 2'
      expect(AccountingPeriodRepository.first.name).to eq 'Period 2'
    end

    it 'should print error on invalid input' do
      expect_to_print_failure_message
      expect_to_print_errors

      run_command 'aperiod', 'update', accounting_period.id.to_s, '-n', ''
      expect(AccountingPeriodRepository.first.name).to eq 'Period 1'
    end

    it 'should print error on invalid id' do
      expect_to_print_failure_message

      run_command 'aperiod', 'update', (accounting_period.id + 1).to_s, '-n', 'Period 2'
    end
  end

  describe '#delete' do

    let(:accounting_period) { create(:accounting_period) }

    before :each do
      accounting_period
    end

    it 'should delete accounting_period when confirmed' do
      expect_to_ask_yes_question answer: 'yes'
      expect_to_print_success_message

      run_command 'aperiod', 'delete', accounting_period.id.to_s
      expect(AccountingPeriodRepository.count).to eq 0
    end

    it 'should delete category when confirmed' do
      expect_to_ask_yes_question answer: 'no'

      run_command 'aperiod', 'delete', accounting_period.id.to_s
      expect(AccountingPeriodRepository.count).to eq 1
    end

    it 'should print error on invalid id' do
      expect_to_print_failure_message

      run_command 'aperiod', 'delete', (accounting_period.id + 1).to_s
    end
  end

end
