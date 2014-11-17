require 'test_helper'

class MemberTest < UnitTest

  describe "a member" do

    it "should save valid member data" do
      member = create(:member)
      member.save.must_equal true
    end

    it "fails to save a member without a phone number" do
      member = create(:member)
      member.cell_phone = nil
      member.save.must_equal false
    end

    it "gets a list of members" do
      2.times{ create(:member) }
      Member.all.length.must_equal 2
    end

    it "makes a valid member number" do
      member = create(:member)
      member.member_number.must_equal Integer(Date.today.year.to_s \
        + (member.id + Member::MEMBER_SEED).to_s.rjust(5, "0"))
    end

    it "knows its membership status" do
      member = create(:member)
      this_year = Date.today.year
      last_year = this_year-1
      im = build(:individual_membership, year: last_year)
      mm = build(:member_membership, member: member, primary: true)
      im.member_memberships << mm
      im.save
      member.paid_up?.must_equal false
      member.lapsed?.must_equal true
      im2 = build(:individual_membership, year: this_year)
      mm2 = build(:member_membership, member: member, primary: true)
      im2.member_memberships << mm2
      im2.save
      member.paid_up?.must_equal true
      member.lapsed?.must_equal false
      member.since.must_equal last_year
    end

    it "knows its role" do
      admin = create(:admin)
      member = create(:member)
      admin.role.must_equal "admin"
      member.role.must_equal "member"
    end

  end

end
