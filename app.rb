ENV['FM_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['FM_ENV'])

require_relative 'config/application'

require_relative 'app/domain/errors'
require_relative 'app/domain/associations'
require_relative 'app/domain/entity'
require_relative 'app/domain/form'
require_relative 'app/domain/entity_form'

require_relative 'app/domain/util/date_parser'

require_relative 'app/repositories/base_repository'
require_relative 'app/repositories/accounting_period_repository'
require_relative 'app/repositories/category_repository'
require_relative 'app/repositories/transaction_repository'
require_relative 'app/repositories/property_repository'

require_relative 'app/domain/property/property'

require_relative 'app/domain/accounting_period/accounting_period'
require_relative 'app/domain/accounting_period/accounting_period_form'

require_relative 'app/domain/transaction/transaction_type'
require_relative 'app/domain/transaction/transaction_search_form'
require_relative 'app/domain/transaction/transaction'
require_relative 'app/domain/transaction/transaction_form'

require_relative 'app/domain/category/category'
require_relative 'app/domain/category/category_form'
require_relative 'app/domain/category/category_search_form'

require_relative 'app/use_cases/concerns/entity_use_case_hooks'
require_relative 'app/use_cases/create_entity'
require_relative 'app/use_cases/update_entity'
require_relative 'app/use_cases/delete_entity'
require_relative 'app/use_cases/find_entity'
require_relative 'app/use_cases/fill_entity_form'
require_relative 'app/use_cases/accounting_periods/create_accounting_period'
require_relative 'app/use_cases/accounting_periods/update_accounting_period'
require_relative 'app/use_cases/accounting_periods/delete_accounting_period'
require_relative 'app/use_cases/accounting_periods/fill_accounting_period_form'
require_relative 'app/use_cases/accounting_periods/find_accounting_period'
require_relative 'app/use_cases/accounting_periods/find_all_accounting_periods'
require_relative 'app/use_cases/accounting_periods/set_current_accounting_period'
require_relative 'app/use_cases/accounting_periods/find_current_accounting_period'
require_relative 'app/use_cases/categories/create_category'
require_relative 'app/use_cases/categories/update_category'
require_relative 'app/use_cases/categories/delete_category'
require_relative 'app/use_cases/categories/fill_category_form'
require_relative 'app/use_cases/categories/find_category'
require_relative 'app/use_cases/categories/find_all_categories'
require_relative 'app/use_cases/transactions/create_transaction'
require_relative 'app/use_cases/transactions/update_transaction'
require_relative 'app/use_cases/transactions/delete_transaction'
require_relative 'app/use_cases/transactions/find_transaction'
require_relative 'app/use_cases/transactions/fill_transaction_form'
require_relative 'app/use_cases/transactions/search_transactions'
require_relative 'app/use_cases/transactions/search_current_transactions'

require_relative 'db/initialize'



