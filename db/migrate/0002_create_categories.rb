class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :category do |t|
      t.string :name
      t.integer :transaction_type

      t.timestamps
    end
  end
end