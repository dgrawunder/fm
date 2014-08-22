class CreateTransaction < CreateEntity

  before_validation do |form|
    if form.template?
      form.accounting_period_id = nil
      form.date = nil
    else
      form.resolve_accounting_period_id!
    end
    form.resolve_category_id!
  end
end