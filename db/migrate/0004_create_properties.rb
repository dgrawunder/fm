class CreateProperties < ActiveRecord::Migration
  def self.up
    create_table :properties do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end