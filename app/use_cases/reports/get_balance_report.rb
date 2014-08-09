class GetBalanceReport

  def initialize identifier=nil
    @identifier = identifier
  end

  def run
    accounting_period = AccountingPeriodRepository.find(accounting_period_id)
    BalanceReport.new(accounting_period)
  end

  private

  def accounting_period_id
    if @identifier.nil?
      PropertyRepository.find_current_accounting_period_id
    else
      AccountingPeriodIdentifierResolver.resolve_to_id(@identifier)
    end
  end
end