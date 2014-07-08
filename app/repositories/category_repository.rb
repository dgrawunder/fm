class CategoryRepository

  include BaseRepository

  def self.exists_by_name_and_transaction_type?(name, transaction_type)
    record_class.where(name: name, transaction_type: transaction_type).exists?
  end
end