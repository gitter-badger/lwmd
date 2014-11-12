require 'test_helper'

class MembershipIntegrationTest < IntegrationTest
  before do
    @admin = sign_in_as_admin
  end

  it "can view a list of memberships" do
    im = build(:individual_membership)
    mm = build(:member_membership, member: create(:member), primary: true)
    im.member_memberships << mm
    im.save
    primary_member = create(:member)
    fm = build(:family_membership)
    pmm = build(:member_membership, member: primary_member, primary: true)
    fm.member_memberships << pmm
    3.times do
      family_member = create(:member)
      fmm = build(:member_membership, member: family_member)
      fm.member_memberships << fmm
    end
    fm.save
    visit memberships_path
    must_have_content im.primary_member.name
    fm.members.each do |m|
      must_have_content m.name
    end
  end

  it "changes the year to see membership history" do
    current_membership = build(:individual_membership, year: Date.today.year)
    current_mm = build(:member_membership, member: create(:member), primary: true)
    current_membership.member_memberships << current_mm
    current_membership.save

    old_membership = build(:individual_membership, year: 2013)
    old_mm = build(:member_membership, member: create(:member), primary: true)
    old_membership.member_memberships << old_mm
    old_membership.save

    visit memberships_path
    must_have_content current_membership.primary_member.name
    wont_have_content old_membership.primary_member.name
    visit memberships_path(year: 2013)
    wont_have_content current_membership.primary_member.name
    must_have_content old_membership.primary_member.name
  end

  it "adds an individual membership" do
    member = create(:member)
    visit new_membership_path
    within("form.new_membership") do
      fill_in 'Price paid', :with => 'First'
      fill_in 'Year', :with => 'Last'
      fill_in 'Date paid', :with => Date.today
      find("input#membership_0").set(member.id)
    end
    click_button 'Add Membership'
    page.must_have_css('.ui.blue.message.closable')
  end

  it "adds a family membership" do
    primary_member = create(:member)
    family_member = create(:member)
    visit new_membership_path(category: "Family")
    within("form.new_membership") do
      fill_in 'Price paid', :with => '$40'
      fill_in 'Year', :with =>  Date.today.year
      fill_in 'Date paid', :with => Date.today
      find("input#membership_0").set(primary_member.id)
      find("input#membership_1").set(family_member.id)
    end
    click_button 'Add Membership'
    page.must_have_css('.ui.blue.message.closable')
  end

  it "wont add a membership with missing fields" do
    member = create(:member)
    visit new_membership_path
    within("form.new_membership") do
      #nothing - just click the button
    end
    click_button 'Add Membership'
    page.wont_have_css('.ui.blue.message.closable')
    page.must_have_css('.ui.red.message')
    page.must_have_content("Price paid can't be blank")
    page.must_have_content("Year can't be blank")
    page.must_have_content("Date paid can't be blank")
    page.must_have_content("Members You need at least one member")
  end
end
