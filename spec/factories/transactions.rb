FactoryGirl.define do
  factory :base_transaction, class: :transaction do

    sequence(:description) { |n| "Transaction #{n}" }
    amount { BigDecimal.new(Forgery(:monetary).money(max: 150), 10) }
    fixed { Forgery(:basic).boolean }
    date { Forgery(:date).date(past: true, future: false, max_delta: 30) }
    type TransactionType[:expense]
    template false

    factory :transaction do

      factory :expense do
        type TransactionType[:expense]
      end

      factory :income do
        type TransactionType[:income]
      end

      factory :outpayment do
        type TransactionType[:outpayment]
      end

      factory :inpayment do
        type TransactionType[:inpayment]
      end

      factory :receivable do
        type TransactionType[:receivable]
      end
    end


    factory :template do
      template true
      date nil
      day_of_month (1..31).to_a.sample
    end
  end
end