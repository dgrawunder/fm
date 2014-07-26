class CategoryRepository

  include BaseRepository

  class << self

    def exists_by_id_and_transaction_type?(id, transaction_type)
      record_class.where(id: id, transaction_type: transaction_type).exists?
    end

    def search_id_by_name_and_transaction_type(search, transaction_type)
      record_class.where(transaction_type: transaction_type).where("name like ?", "%#{search}%").pluck(:id).first
    end

    def search(criteria)
      query = record_class.all
      query = query.where(transaction_type: criteria.transaction_type) if criteria.transaction_type.present?
      query = query.order(criteria.sort) if criteria.sort.present?
      run_query(query)
    end
  end
end