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
      return nil if search.nil?
      record_class.where("name like ?", "%#{search}%").pluck(:id).first
    end

    def all_ordered_by_starts_at_desc
      run_query record_class.order(starts_at: :desc)
    end
  end
end