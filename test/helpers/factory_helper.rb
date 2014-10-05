include FactoryGirl::Syntax::Methods

module FactoryHelper
  FactoryGirl.define do
    sequence(:first_name) { |e| "First Name #{e}"}
    sequence(:last_name) { |e| "Last Name #{e}"}
    sequence(:email) { |e| "test#{Time.now.to_i}-#{e}@example.com" }
    sequence(:line1) { |e| "Line 1 #{e}"}
    sequence(:line2) { |e| "Line 2 #{e}"}
    sequence(:city) { |e| "City #{e}"}
  end
end
