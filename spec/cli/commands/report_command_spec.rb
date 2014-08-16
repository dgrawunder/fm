require 'cli_spec_helper'

describe FmCli::ReportCommand, type: :cli do

  let(:accounting_period) { create(:accounting_period) }
  let(:categories) {
    [
        create(:expense_category),
        create(:income_category),
    ]
  }
  let(:transactions) {
    [
        create(:expense, category_id: categories.first.id, accounting_period_id: accounting_period.id),
        create(:expense, category_id: categories.first.id, accounting_period_id: accounting_period.id),
        create(:income, category_id: categories.second.id, accounting_period_id: accounting_period.id),
        create(:income, category_id: categories.second.id, accounting_period_id: accounting_period.id)
    ]
  }

  before :each do
    transactions
  end

  describe 'category' do
    context 'current accounting period exists' do

      before :each do
        create(:current_accounting_period_id_property, value: accounting_period.id)
      end

      it 'should print current category report for given transaction type' do
        expect_to_print :category_report do |actual_category_report|
          expect(actual_category_report.first.category).to eq categories.second
        end
        run_command 'report', 'category', '-t', 'inc'
      end

      it 'should print current expense category report if no transaction type given' do
        expect_to_print :category_report do |actual_category_report|
          expect(actual_category_report.first.category).to eq categories.first
        end
        run_command 'report', 'category'
      end

      it 'should print failure message if unknown transaction type given' do
        expect_to_print_failure_message
        run_command 'report', 'category', '-t', 'foo'
      end
    end

    context 'when no current accounting period exists' do

      it 'should print failure message' do
        expect_to_print_failure_message
        run_command 'report', 'category'
      end
    end
  end

end