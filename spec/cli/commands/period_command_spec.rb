require 'cli_spec_helper'

describe FmCli::Period, type: :cli do

  describe '#add' do

    it 'should create AccountingPeriod' do
      expect_to_print_success_message
      expect_to_print :accounting_period

      run_command 'period', 'add', 'period 1'
      expect(AccountingPeriodRepository.count).to eq 1
    end

    it 'should print error on invalid input' do
      expect_to_print_failure_message
      expect_to_print_errors

      run_command 'period', 'add', ''
      expect(AccountingPeriodRepository.count).to eq 0
    end
  end

  describe '#list' do

    it 'should list accounting_periods' do
      accounting_periods = [
          create(:accounting_period, starts_at: 3.days.ago),
          create(:accounting_period, starts_at: 1.day.ago),
          create(:accounting_period, starts_at: 2.days.ago)
      ]
      expect_to_print :accounting_periods do |actual_accounting_periods|
        expect(actual_accounting_periods).to eq [accounting_periods.second, accounting_periods.third, accounting_periods.first]
      end
      run_command 'period', 'list'
    end
  end

  describe '#update' do

    let(:accounting_period) { create(:accounting_period, name: 'Period 1') }

    it 'should update AccountingPeriod' do

      expect_to_print_success_message
      expect_to_print :accounting_period

      run_command 'period', 'update', accounting_period.id.to_s, '-n', 'Period 2'
      expect(AccountingPeriodRepository.first.name).to eq 'Period 2'
    end

    it 'should print error on invalid input' do
      expect_to_print_failure_message
      expect_to_print_errors

      run_command 'period', 'update', accounting_period.id.to_s, '-n', ''
      expect(AccountingPeriodRepository.first.name).to eq 'Period 1'
    end

    it 'should print error on invalid id' do
      expect_to_print_failure_message

      run_command 'period', 'update', (accounting_period.id + 1).to_s, '-n', 'Period 2'
    end
  end

  describe '#delete' do

    let(:accounting_period) { create(:accounting_period) }

    it 'should delete AccountingPeriod when confirmed' do
      expect_to_ask_yes_question answer: 'yes'
      expect_to_print_success_message

      run_command 'period', 'delete', accounting_period.id.to_s
      expect(AccountingPeriodRepository.count).to eq 0
    end

    it 'should delete AccountingPeriod when not confirmed' do
      expect_to_ask_yes_question answer: 'no'

      run_command 'period', 'delete', accounting_period.id.to_s
      expect(AccountingPeriodRepository.count).to eq 1
    end

    it 'should print error on invalid id' do
      expect_to_print_failure_message

      run_command 'period', 'delete', (accounting_period.id + 1).to_s
    end
  end

  describe '#current' do

    context 'when called with no option' do

      it 'should print current accounting period if exists' do
        current_accounting_period = create(:accounting_period)
        create(:current_accounting_period_id_property, value: current_accounting_period.id)


        run_command 'period', 'current'
      end

      it 'should print failure message when current AccountingPeriod not exists' do
        expect_to_print_failure_message
        run_command 'period', 'current'
      end
    end

    context 'when called with -p option' do

      it 'should set new current AccountingPeriod if one exists with given name part' do
        accounting_period = create(:accounting_period, name: 'First Accounting Period')

        expect_to_print :accounting_period do |actual_accounting_period|
          expect(actual_accounting_period).to eq accounting_period
        end

        run_command 'period', 'current', '-p', 'First'
      end

      it 'should print failure message when current AccountingPeriod not exists' do
        expect_to_print_failure_message
        run_command 'period', 'current', '-p', 'First'
      end
    end
  end

end
