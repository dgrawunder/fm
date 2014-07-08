ActiveRecord::Base.logger = Logger.new(File.open("#{__dir__}/../log/#{Fmd.env}.log", 'a'))
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: "#{__dir__}/#{Fmd.env}.db")

class ActiveRecordMapper
  class AccountingPeriod < ActiveRecord::Base

    def self.mapped_attributes
      [:name, :starts_at, :ends_at, :initial_deposit]
    end
  end
  class Category < ActiveRecord::Base
    self.table_name = "categories"

    def self.mapped_attributes
      [:name, :transaction_type]
    end
  end
end