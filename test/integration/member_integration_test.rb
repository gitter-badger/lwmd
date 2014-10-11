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
    within("form.new_member") do
      fill_in 'First Name', :with => 'First'
      fill_in 'Last Name', :with => 'Last'
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Birthdate', :with => '3/3/1978'
      fill_in 'USAT Number', :with => '20120434234'
      fill_in 'Cell phone', :with => "555-555-1212"
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
    page.must_have_content("Cell phone is required if home phone isn't given")
    page.must_have_content("Home phone is required if cell phone isn't given")
  end

  it "edits a member" do
    @member = create(:member)
    visit edit_member_path(@member)
    within("form.edit_member") do
      page.find('#member_last_name').value.must_equal @member.last_name
      fill_in 'Cell phone', :with => "555-555-1212"
      fill_in 'Full address', :with => '123 Fake Street, Anytown, KS 55555'
    end
    click_button 'Save'
    page.must_have_css('.ui.blue.message.closable')
     # phony gem normalizes phone number on save
     # but formatting is stripped in tests
    @member.cell_phone.must_equal "15555551212"
    @member.address.city.must_equal "Anytown"
  end

  it "deactivates a member" do
    @member = create(:member)
    visit edit_member_path(@member)
    within("form.edit_member") do
      find("#member_active").set(false)
    end
    click_button 'Save'
    within("tr##{@member.id}") do
      page.wont_have_css('i')
    end
  end
end
