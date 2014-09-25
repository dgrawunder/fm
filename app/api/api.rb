require_relative '../../app'
require 'sinatra'

require 'sinatra/reloader' if Fm.env == 'development'

require 'active_model_serializers'
require_relative 'serializers/transaction_serializer'

get '/' do
  require './config/version'
  "FM Version #{Fm.version}"
end

class Transaction
  include ActiveModel::SerializerSupport
end

get '/expenses' do
  form = TransactionSearchForm.new(type: TransactionType[:expense])
  transactions = SearchTransactions.new(form, only_currents: true).run

  content_type :json
  status 200
  ActiveModel::ArraySerializer.new(
      transactions,
      each_serializer: TransactionSerializer,
      root: 'transactions'
  ).to_json
end