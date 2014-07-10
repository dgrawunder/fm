class CategoryRepository

  include BaseRepository

  class << self

    def exists_by_name_name_and_transaction_type?(name, transaction_type)
      record_class.where(name: name, transaction_type: transaction_type).exists?
    end

    def id_by_name_and_transaction_type(search, transaction_type)
      record_class.where(transaction_type: transaction_type).where("name like ?", "%#{search}%").pluck(:id).first
    end

    def exists_by_name_and_transaction_type?(name, transaction_type)
      record_class.where(name: name, transaction_type: transaction_type).exists?
    end
  end
end