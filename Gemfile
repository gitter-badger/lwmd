source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'

gem 'rails_12factor' #for heroku platform features

# Use postgresql as the database for Active Record
gem 'pg'

# authentication
gem 'devise'
gem 'devise_invitable', '~> 1.3.4' # invite members who register

# haml good. erb bad.
gem 'haml'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'

# UI framework
gem 'semantic-ui-sass', github: 'jwrubel/semantic-ui-sass'
gem 'StreetAddress', '1.0.3', :require => "street_address" # E-Z Addresses
gem 'phony_rails' # phone number formatting

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',        group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',      group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'coffee-rails'

group :test do
  gem 'minitest'
  gem 'minitest-reporters' # test output
  gem 'capybara-webkit'
  gem 'capybara_minitest_spec'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'm', '~> 1.3.1'
end

group :development, :test do
  gem 'factory_girl_rails' # better test fixtures
  gem 'dotenv-rails' # store environment variables locally in .env file
end
