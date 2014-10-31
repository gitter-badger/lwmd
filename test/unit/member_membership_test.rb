require 'test_helper'

class MemberMembershipTest < UnitTest

  describe "valid member_membership data" do

    it "doesnt allow a member to be added to more than one membership per year" do
      member = create(:member)
      first_membership = build(:membership, year: Date.today.year)
      first_membership.members << member
      first_membership.save.must_equal true
      second_membership = build(:membership, year: Date.today.year)
      second_membership.members << member
      second_membership.save.must_equal false
    end

  end
end
