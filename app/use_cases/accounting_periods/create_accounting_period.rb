class CreateAccountingPeriod

  def initialize form
    @form = form
  end

  def run!
    @form.validate!
    AccountingPeriod.new(@form.attributes).save
  end
end