FactoryGirl.define do
  factory :member do
    first_name
    last_name
    email
    active true
    birthdate "1979-02-10"
    cell_phone "555-555-1212"
    password  'password'
    factory :avatar do
       avatar_file_name { 'profile.png' }
       avatar_content_type { 'image/png' }
       avatar_file_size { 8 }
    end
    address

    after(:build) do |m|
      m.generate_member_number
    end

    factory :admin do
      is_admin true
    end
  end
end
