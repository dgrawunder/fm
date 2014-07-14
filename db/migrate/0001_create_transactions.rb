class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :accounting_period_id
      t.integer :category_id
      t.string :description
      t.decimal :amount, :precision => 10, :scale => 2
      t.boolean :expected
      t.boolean :fixed
      t.integer :type
      t.date :date
      t.boolean :template
      t.integer :day_of_month

      t.timestamps
    end
  end
end