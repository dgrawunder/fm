class AccountingPeriodRepository

  include BaseRepository

  class << self

    def exists_by_id?(id)
      record_class.where(id: id).exists?
    end
    
    def exists_by_name?(name)
      record_class.where(name: name).exists?
    end

    def search_id_by_name(search)
      record_class.where("name like ?", "%#{search}%").pluck(:id).first
    end
  end
end