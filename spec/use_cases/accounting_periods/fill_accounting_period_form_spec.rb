describe FillAccountingPeriodForm do

  let(:accounting_period) { create(:accounting_period) }

  subject { FillAccountingPeriodForm.new accounting_period.id }

  it 'should return filled AccountingForm' do

    actual_form = subject.run

    expect(actual_form).to be_instance_of AccountingPeriodForm
    expect(actual_form.name).to eq accounting_period.name
    expect(actual_form.starts_at).to eq accounting_period.starts_at
    expect(actual_form.ends_at).to eq accounting_period.ends_at
    expect(actual_form.initial_deposit).to eq accounting_period.initial_deposit
  end

end