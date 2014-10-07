require 'test_helper'

class MemberTest < UnitTest

  describe "valid member data" do

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

  end

end
