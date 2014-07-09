class AccountingPeriodRepository

  include BaseRepository

  class << self

    def exists_by_name?(name)
      record_class.where(name: name).exists?
    end
  end
end