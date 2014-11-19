class CreateTransaction < CreateEntity

  before_validation do |form|
    if form.template?
      form.accounting_period_id = nil
      form.date = nil
    else
      form.resolve_accounting_period_id!

      if form.accounting_period_id.nil?
        form.accounting_period_id = PropertyRepository.find_current_accounting_period_id
      end
    end
    form.resolve_category_id!
  end
end