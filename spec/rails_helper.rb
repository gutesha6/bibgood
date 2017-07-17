# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'pundit/rspec'
require 'paper_trail/frameworks/rspec'
require 'capybara-screenshot/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

# Capybara.default_driver = :poltergeist
if ENV['IN_BROWSER']
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  Capybara.javascript_driver = :selenium
else
  Capybara.register_driver :poltergeist do |app|
    options = {
      js_errors: true,
      timeout: 360,
      debug: false,
      url_blacklist: %w[placehold youtuve.com vimeo.com gstatic facebook.com],
      phantomjs_options: %w[--disk-cache=false --ignore-ssl-errors=yes],
      inspector: false
    }
    Capybara::Poltergeist::Driver.new(app, options)
  end
  Capybara.javascript_driver = :poltergeist
end

OmniAuth.config.test_mode = true

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include OmniauthHelpers, type: :feature
  config.include FeatureHelpers, type: :feature
  config.include FixtureHelpers
end
