module FmCli
  module Transaction
    def self.included(base)
      base.class_eval do

        def self.common_create_and_update_options
          method_option 'accounting-period', aliases: '-p'
          method_option 'category', aliases: '-c'
          method_option 'date', aliases: '-d'
          method_option 'type', aliases: '-t'
          method_option 'day-of-month', aliases: '-m'
        end

        desc 'add DESCRIPTION AMOUNT [CATEGORY] [OPTIONS]',
             "Add a new transaction to the current or specified accounting period"
        common_create_and_update_options
        method_option 'template', aliases: '-T', type: :boolean, default: false
        method_option 'fixed', aliases: '-f', type: :boolean, default: false
        method_option 'expected', aliases: '-e', type: :boolean, default: false

        def add(description, amount, category=nil)
          attributes = {
              description: description,
              amount: amount,
              template: options[:template],
              category_name: category
          }
          fill_attributes_with_common_create_and_update_options(attributes, options)
          attributes[:template] = options[:template] if options[:template]
          attributes[:day_of_month] = options['day-of-month'] if options['day-of-month']

          run_interaction(:create_entity, attributes, :transaction)
        end

        desc 'update ID [OPTIONS]', 'Update a transaction'
        common_create_and_update_options
        method_option 'description', aliases: '-D'
        method_option 'amount', aliases: '-a'
        method_option 'fixed', aliases: '-f', type: :boolean
        method_option 'expected', aliases: '-e', type: :boolean

        def update(id)
          attributes = {}
          fill_attributes_with_common_create_and_update_options(attributes, options)
          attributes[:description] = options[:description] if options[:description]
          attributes[:amount] = options[:amount] if options[:amount]

          run_interaction(:update_entity, id, attributes, :transaction)
        end

        desc 'delete ID', 'Deletes a transaction forevermore'

        def delete(id)
          run_interaction(:delete_entity, id, :transaction)
        end

        # Creates a listing command for every transaction type e.g. expenses
        TransactionType::TYPES.each do |type_name, type_number|
          desc "#{type_name.to_s.pluralize} [OPTIONS]",
               "List all #{type_name.to_s.pluralize} of current or specified accounting period"
          method_option 'accounting-period', aliases: '-p'
          method_option :templates, aliases: '-T', type: :boolean, default: false

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

        desc 'search SEARCH-TERM', 'Search for current transactions'
        method_option 'type', aliases: '-t'
        method_option 'expected', aliases: '-e', type: :boolean

        def search(search_term=nil)
          attributes = {
              term: search_term
          }
          attributes[:expected] = options[:expected] unless options[:expected].nil?
          attributes[:type] = options[:type] if options[:type]
          run_interaction(:search_transactions, attributes)
        end

        desc 'payed ID', 'Set a transaction as not expected'

        def payed(id)
          attributes = {
              expected: false
          }

          run_interaction(:update_entity, id, attributes, :transaction)
        end

        private

        def fill_attributes_with_common_create_and_update_options(attributes, options)
          attributes[:accounting_period_name] = options['accounting-period'] if options['accounting-period']
          attributes[:category_name] = options[:category] if options[:category]
          attributes[:date] = options[:date] if options[:date]
          attributes[:expected] = options[:expected] unless options[:expected].nil?
          attributes[:type] = options[:type] if options[:type]
          attributes[:fixed] = options[:fixed] if options[:fixed]
        end
      end
    end
  end
end