require 'test_helper'

class Api::MembershipsIntegrationTest < ApiTest

  describe "creating memberships from json" do

    it "creates a family membership from json" do
      header "Api-Key", "#{ZAPIER_SECRET_TOKEN}"
      membership_data = JSON.parse(File.read(Rails.root+'test/fixtures/family_membership.json'))
      post api_memberships_path, membership_data
      last_response.ok?.must_equal true
      Membership.member_ids_for_year("2014").length.must_equal 4
    end

  end

end
