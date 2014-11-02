FactoryGirl.define do
  factory :membership do
    factory :individual_membership do
      category "Individual"
      price_paid 40.00
      year Date.today.year
      date_paid Date.today
      active true
    end

    factory :family_membership do
      category "Family"
      price_paid 65.00
      year Date.today.year
      date_paid Date.today
      active true
    end
  end
end
