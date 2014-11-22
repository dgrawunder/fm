class Transaction < Entity
  include Lift

  attr_accessor :id, :accounting_period_id, :category_id, :description, :amount,
                :expected, :fixed, :template, :type, :date, :day_of_month, :repaid
  alias :expected? :expected
  alias :template? :template
  alias :fixed? :fixed
  alias :repaid? :repaid

  belongs_to :accounting_period
  belongs_to :category
end