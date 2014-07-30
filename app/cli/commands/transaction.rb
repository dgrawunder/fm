module FmCli
  module Transaction
    def self.included(base)
      base.class_eval do

        def self.common_create_and_update_options
          method_option 'accounting-period', aliases: '-p'
          method_option 'category', aliases: '-c'
          method_option 'description', aliases: '-d'
          method_option 'amount', aliases: '-a'
          method_option 'type', aliases: '-t'
        end

        desc 'add OPTIONS ...', 'Adds a transaction to the current accounting period'
        common_create_and_update_options

        def add
          attributes = {}
          fill_attributes_with_common_create_and_update_options(attributes, options)

          run_interaction(:create_entity, attributes, :transaction)
        end

        desc 'delete <id>', 'Deletes a transaction forevermore'

        def delete(id)
          run_interaction(:delete_entity, id, :transaction)
        end

        private

        def fill_attributes_with_common_create_and_update_options(attributes, options)
          attributes[:accounting_period_name] = options['accounting-period'] if options['accounting-period']
          attributes[:category_name] = options[:category] if options[:category]
          attributes[:description] = options[:description] if options[:description]
          attributes[:amount] = options[:amount] if options[:amount]
          attributes[:type] = options[:type] if options[:type]
        end
      end
    end
  end
end