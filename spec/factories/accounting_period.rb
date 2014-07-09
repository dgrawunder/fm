FactoryGirl.define do
  factory :accounting_period do
    sequence(:name) { |n| "Accounting Period #{n}" }
    starts_at Date.current - 15.days
    ends_at Date.current + 15.days
    initial_deposit 2566.98
  end
end