class TransactionRepository
  include BaseRepository

  class << self

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