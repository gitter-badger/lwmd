require 'test_helper'

class MembershipTest < UnitTest

  describe "valid membership data" do

    it "should save valid member data" do
      membership = build(:membership)
      membership.members << create(:member)
      membership.save.must_equal true
    end

    it "wont save a membership without a member" do
      membership = build(:membership)
      membership.save.must_equal false
    end

    it "associates a member with a membership" do
      membership = build(:membership)
      member = create(:member)
      membership.members << member
      membership.save.must_equal true
      member.memberships.length.must_equal 1
    end

    it "only allows one member for an individual membership" do
      membership = build(:membership, category: "Individual")
      member = create(:member)
      another_member = create(:member)
      membership.members << member
      membership.members << another_member
      membership.save.must_equal false
    end

    it "Doesnt allow more than the max members per membership" do
      membership = build(:membership, category: "Family")
      5.times do
        member = create(:member)
        membership.members << member
      end
      membership.save.must_equal false
    end
  end
end
