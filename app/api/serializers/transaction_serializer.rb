class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :description, :amount, :date, :type, :expected, :fixed

end