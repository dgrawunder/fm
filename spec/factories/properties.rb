FactoryGirl.define do

  factory :property do
    key { Forgery(:basic).text }
    value { Forgery(:basic).text }

    factory :current_accounting_period_id_property do
      key { Property::CURRENT_ACCOUNTING_PERIOD_ID }
    end
  end
end