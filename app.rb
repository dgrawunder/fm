ENV['FMD_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['FMD_ENV'])

require_relative 'config/application'

require_relative 'app/domain/errors'
require_relative 'app/domain/model'
require_relative 'app/domain/form'

require_relative 'app/domain/accounting_periods/accounting_period'
require_relative 'app/domain/accounting_periods/accounting_period_form'


require_relative 'app/repositories/base_repository'
require_relative 'app/repositories/accounting_period_repository'
require_relative 'app/repositories/category_repository'

require_relative 'app/domain/transactions/transaction_type'
require_relative 'app/domain/transactions/transaction'
require_relative 'app/domain/transactions/transaction_type_finder'

require_relative 'app/domain/categories/category'
require_relative 'app/domain/categories/category_form'

require_relative 'app/use_cases/accounting_periods/create_accounting_period'

require_relative 'app/use_cases/categories/create_category'
require_relative 'app/use_cases/categories/update_category'
require_relative 'app/use_cases/categories/delete_category'
require_relative 'app/use_cases/categories/fill_category_form'

require_relative 'db/initialize'



