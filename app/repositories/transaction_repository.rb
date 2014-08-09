class TransactionRepository
  include BaseRepository

  class << self

    # Defines method like expenses_by_accounting_period_id for every TransactionType except revenues
    TransactionType::TYPES.except(:receivable).each do |name, number|
      define_method("#{name.to_s.pluralize}_by_accounting_period_id") do |accounting_period_id|
        build_entities record_class.where(accounting_period_id: accounting_period_id, type: number)
      end
    end

    def receivables
      build_entities record_class.where(type: TransactionType[:receivable])
    end

    def search(criteria, include: [])
      includes = Array(include)
      query = record_class.all
      query = query.where(accounting_period_id: criteria.accounting_period_id) if criteria.accounting_period_id.present?
      query = query.where(type: criteria.type) if criteria.type.present?
      query = query.where(template: criteria.template) unless criteria.template.nil?
      query = query.order(criteria.sort) if criteria.sort.present?
      query = query.includes(:category) if includes.include? :category
      run_query(query, includes)
    end
  end
end