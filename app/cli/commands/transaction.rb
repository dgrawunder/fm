module FmCli
  module Transaction
    def self.included(base)
      base.class_eval do

        desc 'add OPTIONS ...', 'Adds a transaction to the current accounting period'
        method_option 'category', aliases: '-c'
        method_option 'description', aliases: '-d'
        method_option 'amount', aliases: '-a'

        def add
          attributes = {}
          attributes[:category] = options[:category] if options[:category]
          attributes[:description] = options[:description] if options[:description]
          attributes[:amount] = options[:amount] if options[:amount]

          run_interaction(:create_entity, attributes, :transaction)
        end
      end
    end
  end
end