require 'test_helper'

class MemberMembershipTest < UnitTest

  describe "valid member_membership data" do

    it "doesnt allow a member to be added to more than one membership per year" do
      member = create(:member)
      first_membership = build(:individual_membership, year: Date.today.year)
      mm1 = build(:member_membership, member: member)
      first_membership.member_memberships << mm1
      first_membership.save.must_equal true
      second_membership = build(:individual_membership, year: Date.today.year)
      mm2 = build(:member_membership, member: member)
      second_membership.member_memberships << mm2
      second_membership.save.must_equal false
    end

  end
end
