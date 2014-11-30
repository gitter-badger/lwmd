require 'test_helper'

class HelpIntegrationTest < IntegrationTest

  describe "members needing help" do
    before do
      visit help_path
    end

    it "wont find a member if email incorrect" do
      within("form") do
        fill_in "email", with: "not_a_member@example.com"
        click_button("Check email")
      end
      page.must_have_content "We couldn't find an account with email"
    end

    it "sends invitation if a member is found but not active" do
      member = create(:member)
      within("form") do
        fill_in "email", with: member.email
        click_button("Check email")
      end
      page.must_have_content "Success"
      page.must_have_content "We found your account! You need an invitation \
      token to sign in, though."
    end

    it "sends password reset if active member found" do
      member = create(:member, invitation_accepted_at: Date.today, )
      within("form") do
        fill_in "email", with: member.email
        click_button("Check email")
      end
      page.must_have_content "Success"
      page.must_have_content "We found your account! Looks like you may \
      have forgotten your password."
    end
  end
end
