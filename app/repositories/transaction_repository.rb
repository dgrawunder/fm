class TransactionRepository
  include BaseRepository

  class << self

    # Defines method like expenses_by_accounting_period_id for every TransactionType
    TransactionType::TYPES.each do |name, number|
      define_method("#{name.to_s.pluralize}_by_accounting_period_id") do |accounting_period_id|
        build_entities record_class.where(accounting_period_id: accounting_period_id, type: number)
      end
    end

    def templates
      build_entities record_class.where(template: true)
    end

    def receivables(accounting_period_id: nil, only_open: false)
      criteria = TransactionSearchForm.new(
          receivable: true, template: false, accounting_period_id: accounting_period_id)
      criteria.repaid = false if only_open
      search(criteria)
    end

    def search(criteria, include: [])
      includes = Array(include)
      query = record_class.all
      query = query.where(accounting_period_id: criteria.accounting_period_id) if criteria.accounting_period_id.present?
      query = query.where(type: criteria.type) if criteria.type.present?
      unless criteria.template.nil?
        query = query.where(template: criteria.template? ? true : [false, nil])
      end
      unless criteria.expected.nil?
        query = query.where(expected: criteria.expected? ? true : [false, nil])
      end
      unless criteria.receivable.nil?
        query = query.where(receivable: criteria.receivable? ? true : [false, nil])
      end
      unless criteria.repaid.nil?
        query = query.where(repaid: criteria.repaid? ? true : [false, nil])
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