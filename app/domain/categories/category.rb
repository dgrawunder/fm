class Category
  include Lift
  include Equalizer.new(:id)

  attr_accessor :id, :name, :transaction_type
end