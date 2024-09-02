source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.1"

gem "sinatra"
gem "sinatra-contrib"
gem "geocoder"
gem "google_places"
gem "http"
gem 'rack'

# Use Puma as the app server
gem "puma", "~> 5.0"

# use active record
gem "sinatra-activerecord"

# store environment variables
gem 'dotenv', groups: [:development, :test]

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "table_print"
  gem "appdev_support"
end

group :development, :test do
  gem "grade_runner"
  gem "pry"
  gem "sqlite3", "~> 1.4"
end

group :test do
  gem "capybara"
  gem "draft_matchers"
  gem "rspec"
  gem "rspec-html-matchers"
  gem "webmock"
  gem "webdrivers"
  gem "i18n"
end
