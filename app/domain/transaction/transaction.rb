class Transaction < Entity
  include Lift

  attr_accessor :id, :accounting_period_id, :category_id, :description, :amount,
                :expected, :fixed, :template, :type, :date, :day_of_month
end