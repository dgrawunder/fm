class AddRepaidToTransactions < ActiveRecord::Migration
  def self.up
    add_column :transactions, :repaid, :boolean, default: false
  end

  def self.down
    remove_column :transactions, :repaid
  end
end