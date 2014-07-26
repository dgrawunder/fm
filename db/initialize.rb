unless Fm.env == 'test'
  ActiveRecord::Base.logger = Logger.new(File.open("#{__dir__}/../log/#{Fm.env}.log", 'a'))
end
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: "#{__dir__}/#{Fm.env}.db")

class ActiveRecordMapper
  class AccountingPeriod < ActiveRecord::Base

    def self.mapped_attributes
      [:name, :starts_at, :ends_at, :initial_deposit]
    end
  end

  class Category < ActiveRecord::Base

    has_many :transactions, dependent: :nullify

    def self.mapped_attributes
      [:name, :transaction_type]
    end
  end

  class Transaction < ActiveRecord::Base
    self.inheritance_column = 'not_used'

    belongs_to :category

    def self.mapped_attributes
      [
          :accounting_period_id,
          :category_id,
          :description,
          :amount,
          :date,
          :type,
          :expected,
          :fixed,
          :template,
          :day_of_month
      ]
    end
  end


  class Property < ActiveRecord::Base

    def self.mapped_attributes
      [:key, :value]
    end
  end
end