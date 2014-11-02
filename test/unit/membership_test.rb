require 'test_helper'

class MembershipTest < UnitTest

  describe "valid membership data" do

    it "wont save a membership without a member" do
      membership = build(:individual_membership)
      membership.save.must_equal false
    end

    it "associates a member with a membership" do
      member = create(:member)
      membership = build(:individual_membership)
      mm = build(:primary_member_membership, member: member)
      membership.member_memberships << mm
      membership.save.must_equal true
    end

    it "only allows one member for an individual membership" do
      member = create(:member)
      another_member = create(:member)
      membership = build(:individual_membership)
      mm1 = build(:primary_member_membership, member: member)
      mm2 = build(:primary_member_membership, member: member)
      membership.member_memberships << mm1
      membership.member_memberships << mm2
      membership.save.must_equal false
    end

    it "Doesnt allow more than the max members per membership" do
      membership = build(:family_membership)
      5.times do
        fmm = build(:family_member_membership)
        membership.member_memberships << fmm
      end
      membership.save.must_equal false
    end
  end
end
