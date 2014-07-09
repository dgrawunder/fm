class Transaction
  include Lift

  attr_accessor :id, :accounting_period_id, :category_id, :description, :amount,
                :expected_amount, :fixed, :type, :happend_at
end