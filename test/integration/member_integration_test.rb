require 'test_helper'

class UserIntegrationTest < IntegrationTest
  before do

  end

  it "can view a list of members" do
    @member = create(:member)
    visit members_path
    must_have_content @member.name
  end

  it "adds a new member" do
    visit new_member_path
    within("#new_member") do
      fill_in 'First Name', :with => 'First'
      fill_in 'Last Name', :with => 'Last'
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Birthdate', :with => '3/3/1978'
      fill_in 'USAT Number', :with => '20120434234'
      fill_in 'Full address', :with => '123 Fake Street, Anytown, KS 55555'
      fill_in 'Notes', :with => 'These are notes'
    end
    click_button 'Add Member'
    page.must_have_css('.ui.blue.message.closable')
    Address.last.city.must_equal 'Anytown'
  end

  it "wont add a member with missing or invalid" do
    visit new_member_path
    click_button 'Add Member'
    page.must_have_css('.ui.red.message')
    page.must_have_content("First name can't be blank")
    page.must_have_content("Last name can't be blank")
    page.must_have_content("Email can't be blank")
    page.must_have_content("Email is invalid")
  end
end
