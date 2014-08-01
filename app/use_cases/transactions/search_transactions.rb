class SearchTransactions

  def initialize form
    @form = form
  end

  def run
    @form.sort = 'date desc' if @form.sort.nil?
    TransactionRepository.search(@form, include: :category)
  end
end