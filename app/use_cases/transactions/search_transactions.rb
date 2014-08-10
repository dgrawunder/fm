class SearchTransactions

  def initialize form, only_currents: false
    @form = form
    @only_currents = only_currents
  end

  def run

    if search_for_currents?
      @form.accounting_period_id = PropertyRepository.find_current_accounting_period_id
    end

    apply_default_sort if @form.sort.nil?

    TransactionRepository.search(@form, include: :category)
  end

  private

  def search_for_currents?
    @only_currents && @form.type != TransactionType[:receivable]
  end

  def apply_default_sort
    if @form.template?
      @form.sort = 'day_of_month asc'
    else
      @form.sort = 'date desc'
    end
  end
end