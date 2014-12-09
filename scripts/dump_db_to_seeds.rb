require_relative '../app'

class ActiveRecordMapper

  File.open('db/seeds/seed_dev_db.rb', 'w') do |file|

    AccountingPeriod.all.each do |transaction|
      file.write "AccountingPeriod.create(#{transaction.attributes.except('created_at', 'updated_at').
                     merge('initial_deposit' => transaction.initial_deposit.to_f,
                           'starts_at' => transaction.starts_at.to_s,
                           'ends_at' => transaction.ends_at.to_s)})\n"
    end

    Category.all.each do |transaction|
      file.write "Transaction.create(#{transaction.attributes.except('created_at', 'updated_at')})\n"
    end

    Category.all.each do |transaction|
      file.write "Category.create(#{transaction.attributes.except('created_at', 'updated_at')})\n"
    end

    Transaction.all.each do |transaction|
      file.write "Transaction.create(#{transaction.attributes.except('adjustment', 'created_at', 'updated_at').
                     merge('amount' => transaction.amount.to_f, 'date' => transaction.date.to_s)})\n"
    end

    Property.all.each do |transaction|
      file.write "Property.create(#{transaction.attributes.except('created_at', 'updated_at')})\n"
    end
  end
end
