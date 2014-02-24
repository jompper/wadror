source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

gem 'bcrypt-ruby', '~> 3.1.2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use httpary
gem 'httparty'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# For settings storage
gem "rails-settings-cached", "0.3.1"

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'jquery-turbolinks'

gem 'bootstrap-sass'

group :development do
  gem 'rails_layout'
end


group :production do
  # Use PostgreSQL as the database for Active Record in Production mode (Heroku)
  gem 'pg'
  gem 'rails_12factor'
end

group :development, :test do
  # Use sqlite3 as the database for Active Record in Development / Test mode (local)
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.14.1'
  gem 'byebug'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'launchy'
  gem 'simplecov', require: false
  gem 'webmock'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end