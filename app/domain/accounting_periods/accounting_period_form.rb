class AccountingPeriodForm < Form

  attribute :name, String
  attribute :starts_at, Date
  attribute :ends_at, Date
  attribute :initial_deposit, BigDecimal, default: BigDecimal.new(0)

  validates :name, presence: true, length: {maximum: 32}
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :initial_deposit, presence: true
end