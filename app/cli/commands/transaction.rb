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

        desc 'update <id> [OPTIONS]', 'updates a transaction'
        common_create_and_update_options

        def update(id)
          attributes = {}
          fill_attributes_with_common_create_and_update_options(attributes, options)

          run_interaction(:update_entity, id, attributes, :transaction)
        end

        desc 'delete <id>', 'Deletes a transaction forevermore'

        def delete(id)
          run_interaction(:delete_entity, id, :transaction)
        end

        TransactionType::TYPES.each do |type_name, type_number|
          desc "#{type_name}", "Shows all #{type_name.to_s.pluralize}"
          method_option 'accounting-period', aliases: '-p'
          method_option :templates, aliases: '-t', type: :boolean, default: false

          define_method type_name.to_s.pluralize do
            attributes = {
                type: type_number,
                template: options[:templates]
            }
            unless options[:templates]
              attributes[:accounting_period_name] = options['accounting-period'] if options['accounting-period']
            end
            run_interaction(:list_transaction, attributes)
          end
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