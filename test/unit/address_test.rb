require 'test_helper'

class AddressTest < UnitTest

  it "should build a valid address" do
    address = create(:address)
    address.save.must_equal true
  end

end
