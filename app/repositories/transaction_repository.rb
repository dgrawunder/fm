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
      build_entities record_class.where(type: TransactionType[:receivable], template: false)
    end

    def templates
      build_entities record_class.where(template: true)
    end

    def search(criteria, include: [])
      includes = Array(include)
      query = record_class.all
      query = query.where(accounting_period_id: criteria.accounting_period_id) if criteria.accounting_period_id.present?
      query = query.where(type: criteria.type) if criteria.type.present?
      unless criteria.template.nil?
        query = query.where(template: criteria.template?) if criteria.template?
        query = query.where(template: [criteria.template?, nil]) unless criteria.template?
      end
      unless criteria.expected.nil?
        query = query.where(expected: criteria.expected?) if criteria.expected?
        query = query.where(expected: [criteria.expected?, nil]) unless criteria.expected?
      end
      if criteria.term.present?
        query = query.
            joins('LEFT OUTER JOIN categories ON categories.id = transactions.category_id').
            where(*term_search_condition(criteria.term))
      end
      query = query.order(criteria.sort) if criteria.sort.present?
      query = query.includes(:category) if includes.include? :category
      run_query(query, includes)
    end

    private

    def term_search_condition(search_term)
      condition = textual_term_search_condition
      args = {search_term: "%#{search_term}%"}
      if search_term.numeric?
        condition = "#{condition} OR #{numeric_term_search_condition}"
        amount = search_term.to_f
        args[:min_amount] = amount - 0.01
        args[:max_amount] = amount + 0.01
      end
      [condition, args]
    end

    def textual_term_search_condition
      ['transactions.description', 'categories.name'].map { |column| column.to_s + ' LIKE :search_term' }.join(' OR ')
    end

    def numeric_term_search_condition
      "(amount > :min_amount AND amount < :max_amount)"
    end
  end
end