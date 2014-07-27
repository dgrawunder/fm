class FindAllCategories

  def initialize(transaction_type_name=nil)
    @transaction_type_name = transaction_type_name
  end

  def run

    criteria = CategorySearchForm.new(sort: 'name asc')
    if @transaction_type_name.present?
      transaction_type = TransactionType.find_number(@transaction_type_name)
      raise UnknownTransactionTypeError if transaction_type.nil?
      criteria.transaction_type = transaction_type
    end
    CategoryRepository.search(criteria)
  end
end