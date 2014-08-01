class AccountingPeriodForm < EntityForm

  attribute :name, String
  attribute :starts_at, Date, default: lambda { |form, starts_at| form.starts_at = Date.today }
  attribute :ends_at, Date, default: lambda { |form, ends_at| form.ends_at = Date.today + 30.days }
  attribute :initial_deposit, BigDecimal, default: BigDecimal.new(0)

  validates :name, presence: true, length: {maximum: 32}
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :initial_deposit, presence: true
  validate do |form|
    if AccountingPeriodRepository.exists_by_name?(form.name)
      errors.add :name, I18n.t('errors.messages.taken')
    end
  end

end