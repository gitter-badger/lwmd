require 'test_helper'

class UserIntegrationTest < IntegrationTest
  before do
    @member = create(:member)
  end
  it "can view a list of members" do
    visit members_path
    must_have_content @member.name
  end
end
