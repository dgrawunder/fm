module FmCli
  module Transaction
    def self.included(base)
      base.class_eval do

        desc 'add OPTIONS ...', 'Adds a transaction to the current accounting period'
        method_option 'accounting-period', aliases: '-p'
        method_option 'category', aliases: '-c'
        method_option 'description', aliases: '-d'
        method_option 'amount', aliases: '-a'

        def add
          attributes = {}
          attributes[:category] = options[:category] if options[:category]
          attributes[:description] = options[:description] if options[:description]
          attributes[:amount] = options[:amount] if options[:amount]

          if options['accounting-period']
            attributes[:accounting_period_name] = options['accounting-period']
          else
            attributes[:accounting_period_id] = PropertyRepository.find_current_accounting_period_id
          end

          run_interaction(:create_entity, attributes, :transaction)
        end
      end
    end
  end
end