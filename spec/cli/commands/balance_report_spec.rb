require 'cli_spec_helper'

describe FmCli::BalanceCommand, type: :cli do

  let(:accounting_periods) do
    [
        create(:accounting_period),
        create(:accounting_period)
    ]
  end

  before :each do
    create(:current_accounting_period_id_property, value: accounting_periods.second.id)
  end

  it 'should print current balance report' do
    expect_to_print :balance_report do |actual_balance_report|
     expect(actual_balance_report.accounting_period).to eq accounting_periods.second
    end
    run_command 'balance'
  end
end