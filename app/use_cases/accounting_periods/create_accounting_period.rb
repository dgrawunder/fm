class CreateAccountingPeriod < CreateEntity

  after_save do |accounting_period|

    TransactionRepository.templates.each do |template|

      transaction = template.dup
      transaction.accounting_period_id = accounting_period.id
      transaction.template = false
      transaction.date = DateUtil.find_date(
          accounting_period.starts_at,
          accounting_period.ends_at,
          template.day_of_month
      )
      transaction.day_of_month = nil
      transaction.save
    end
  end

end