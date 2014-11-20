require 'test_helper'

# Note that we only check the permissions not
# tested as part of the existing entity
# integration tests.
class PermissionsIntegrationTest < IntegrationTest

  describe "a member" do
    before do
      @member = sign_in_as_member
      @other_member = create(:member)
    end

    it "cant view other member profiles" do
      visit member_path(@other_member)
      page.must_have_content("You are not authorized to perform this action.")
    end

    it "cant view memberships" do
      visit memberships_path
      page.must_have_content("You are not authorized to perform this action.")
    end

  end
end
