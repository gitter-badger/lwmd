require 'test_helper'

class MemberTest < UnitTest

  describe "valid member data" do
    it "should save valid member data" do
      member = create(:member)
      member.save.must_equal true
    end

    it "gets a list of members" do
      2.times{ create(:member) }
      Member.all.length.must_equal 2
    end
  end

end
