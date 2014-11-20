ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require 'helpers/factory_helper'
require 'database_cleaner'

Capybara.default_driver = :rack_test

DatabaseCleaner.strategy = :truncation

class UnitTest < MiniTest::Spec
  before do
    DatabaseCleaner.clean
  end

  after do

  end
end

class IntegrationTest < UnitTest
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  Capybara.register_driver :rack_test do |app|
    Capybara::RackTest::Driver.new app, \
      redirect_limit: 15,
      follow_redirects: true,
      respect_data_method: true
  end

  before do
    DatabaseCleaner.clean
  end

  after do

  end

  def sign_in(member)
    visit unauthenticated_root_path
    within("form#new_member") do
      fill_in 'member_email', with: member.email
      fill_in 'member_password', with: member.password
      click_on 'Log in'
    end
    page.must_have_content("Signed in successfully.")
  end

  def sign_in_as_member
    member = create(:member)
    sign_in(member)
    page.must_have_content "PTC Virtual Membership Card"
    page.must_have_content member.name
    member
  end

  def sign_in_as_admin
    admin = create(:admin)
    sign_in(admin)
    page.must_have_content "Memberships"
    admin
  end
end
