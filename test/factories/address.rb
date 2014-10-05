FactoryGirl.define do
  factory :address do
    line1
    line2
    city
    state "PA"
    postal_code "15222"
    member
  end
end
