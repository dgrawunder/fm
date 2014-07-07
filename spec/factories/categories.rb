FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    transaction_type TransactionType.numbers.sample

    factory :expense_category do
      transaction_type TransactionType[:expense]
    end

    factory :income_category do
      transaction_type TransactionType[:income]
    end

    factory :inpayment_category do
      transaction_type TransactionType[:inpayment]
    end

    factory :outpayment_category do
      transaction_type TransactionType[:outpayment]
    end

    factory :receivable_category do
      transaction_type TransactionType[:receivable]
    end
  end
end