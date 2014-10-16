class TransactionForm < EntityForm

  attribute :accounting_period_id, Integer
  attribute :category_id, Integer
  attribute :description, String
  attribute :amount, BigDecimal
  attribute :date, ParsedDate, default: lambda { |form, attribute| Date.today }
  attribute :expected, Boolean, default: false
  attribute :type, TransactionType, default: TransactionType[:expense]
  attribute :fixed, Boolean, default: false
  attribute :template, Boolean, default: false
  attribute :day_of_month, Integer

  attr_writer :accounting_period_name, :category_name

  validates :description, presence: true, length: {maximum: 35}
  validates :amount, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :type, inclusion: TransactionType.numbers
  validates :day_of_month, numericality: {greater_than: 0, less_than: 32}, allow_nil: true

  validate :validate_presence_of_accounting_period
  validate :validate_existence_of_accounting_period_id
  validate :validate_existence_of_category_id
  validate :validate_presence_of_date
  validate :validate_presence_of_day_of_month
  validate :validate_receivable_cannot_be_template

  def resolve_category_id!
    if category_name.present?
      self.category_id = CategoryRepository.search_id_by_name_and_transaction_type(category_name, type)
      raise UnknownCategoryError, "Couldn't find category with given name" if category_id.nil?
    end
  end

  def resolve_accounting_period_id!
    if accounting_period_name.present?
      self.accounting_period_id = AccountingPeriodRepository.search_id_by_name(accounting_period_name)
    end
  end

  private

  attr_reader :accounting_period_name, :category_name

  private

  def validate_presence_of_accounting_period
    if template? || type == TransactionType[:receivable]
      errors.add :accounting_period_id, I18n.t('errors.messages.present') if accounting_period_id.present?
    else
      errors.add :accounting_period_id, I18n.t('errors.messages.blank') if accounting_period_id.nil?
    end
  end

  def validate_existence_of_accounting_period_id
    if accounting_period_id.present? &&
        !AccountingPeriodRepository.exists_by_id?(accounting_period_id)
      errors.add :accounting_period_id, "doesn't exists"
    end
  end

  def validate_existence_of_category_id
    if category_id.present? &&
        !CategoryRepository.exists_by_id_and_transaction_type?(category_id, type)
      errors.add :category_id, "doesn't exists"
    end
  end


  def validate_presence_of_date
    if template
      errors.add :date, I18n.t('errors.messages.present') if date.present?
    else
      errors.add :date, I18n.t('errors.messages.blank') if date.nil?
    end
  end

  def validate_presence_of_day_of_month
    if template?
      errors.add :day_of_month, I18n.t('errors.messages.blank') if day_of_month.nil?
    else
      errors.add :day_of_month, I18n.t('errors.messages.present') if day_of_month.present?
    end
  end

  def validate_receivable_cannot_be_template
    if template? && type == TransactionType[:receivable]
      errors.add :template, 'cannot be a receivable'
    end
  end
end