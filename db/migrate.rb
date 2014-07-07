require_relative '../app'
require_relative 'initialize'

ActiveRecord::Migrator.migrate('./db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil)