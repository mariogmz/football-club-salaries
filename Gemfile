# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "config", "~> 2.2"
gem "grape"
gem "grape-jwt-authentication"
gem "grape_logging"
gem "grape-swagger"
gem "json"
gem "jwt"
gem "multi_json"
gem "rake"
gem "rack"
gem "racksh"
gem "rack-cors"

group :development, :test do
  gem "airborne"
  gem "byebug"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails_config", require: false
end

group :development do
  gem "brakeman"
  gem "guard"
  gem "guard-minitest"
  gem "guard-rack"
  gem "guard-rubocop"
end

group :test do
  gem "m", "~> 1.5.0"
  gem "minitest"
  gem "mocha"
  gem "rack-test", require: "rack/test"
  gem "simplecov", require: false
end
