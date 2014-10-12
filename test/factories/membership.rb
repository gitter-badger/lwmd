FactoryGirl.define do
  factory :membership do
    category "Individual"
    price_paid 40.00
    year Date.today.year
    date_paid Date.today
    active true
  end
end
