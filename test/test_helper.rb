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
    visit new_member_session_path
    within("form.new_member") do
      fill_in 'member_email', with: member.email
      fill_in 'member_password', with: member.password
      click_on 'Log in'
    end
  end

  def sign_in_as_admin
    admin = create(:admin)
    sign_in(admin)
    admin
  end
end
