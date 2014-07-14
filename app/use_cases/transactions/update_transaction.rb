class UpdateTransaction < UpdateEntity

  before_validation do |form|
    form.resolve_accounting_period_id!
    form.resolve_category_id!
  end
end