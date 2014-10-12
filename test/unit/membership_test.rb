require 'test_helper'

class MembershipTest < UnitTest

  describe "valid membership data" do

    it "should save valid member data" do
      membership = create(:membership)
      membership.save.must_equal true
    end

    it "associates a member with a membership" do
      membership = create(:membership)
      member = create(:member)
      membership.members << member
      member.memberships.length.must_equal 1
    end

  end

end
