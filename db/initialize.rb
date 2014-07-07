ActiveRecord::Base.logger = Logger.new(File.open("#{__dir__}/../log/#{Fmc.env}.log", 'a'))
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: "#{__dir__}/#{Fmc.env}.db")

class ActiveRecordMapper
  class Category < ActiveRecord::Base
    self.table_name = "categories"

    def self.mapped_attributes
      [:name, :transaction_type]
    end
  end
end