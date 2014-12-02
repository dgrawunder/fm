class AddReceivableToTransactions < ActiveRecord::Migration
  def self.up
    add_column :transactions, :receivable, :boolean, default: false
  end

  def self.down
    remove_column :transactions, :receivable
  end
end