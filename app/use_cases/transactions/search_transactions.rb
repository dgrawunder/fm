class SearchTransactions

  def initialize form
    @form = form
  end

  def run
    if @form.sort.nil?
      if @form.template?
        @form.sort = 'day_of_month asc'
      else
        @form.sort = 'date desc'
      end
    end
    TransactionRepository.search(@form, include: :category)
  end
end