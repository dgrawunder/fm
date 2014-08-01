class SearchCurrentTransactions

  def initialize form
    @form = form
  end

  def run

    unless @form.type == TransactionType[:receivable]
      @form.accounting_period_id = PropertyRepository.find_current_accounting_period_id
    end

    SearchTransactions.new(@form).run
  end
end