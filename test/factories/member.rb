FactoryGirl.define do
  factory :member do
    first_name
    last_name
    email
    active true
    cell_phone "555-555-1212"
    password  'password'
    after(:build) do |m|
      m.generate_member_number
    end

    factory :admin do
      is_admin true
    end
  end
end
