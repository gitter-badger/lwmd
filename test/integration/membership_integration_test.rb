require 'test_helper'

class MemberIntegrationTest < IntegrationTest
  before do

  end

  it "can view a list of members" do
    @member = create(:member)
    visit members_path
    must_have_content @member.name
  end

  it "adds a member" do

  end

  it "wont add a member with missing fields" do

  end

  it "wont add a membership without at least one member" do

  end
end
