FactoryGirl.define do
  factory :member_membership do
    factory :primary_member_membership do
      primary true
      member
    end

    factory :family_member_membership do
      primary false
      member
    end
  end
end
