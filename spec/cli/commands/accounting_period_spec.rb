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

end
