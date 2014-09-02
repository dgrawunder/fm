class CreateAccountingPeriods < ActiveRecord::Migration
  def self.up
    create_table :accounting_periods do |t|
      t.string :name
      t.date :starts_at
      t.date :ends_at
      t.decimal :initial_deposit, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end