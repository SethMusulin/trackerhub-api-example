# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  VCR.configure do |c|
    c.cassette_library_dir = 'spec/vcr'
    c.hook_into :webmock

    c.filter_sensitive_data('<GITHUB_USERNAME>') { ENV['GITHUB_USERNAME'] }
    c.filter_sensitive_data('<GITHUB_PASSWORD>') { ENV['GITHUB_PASSWORD'] }
    c.filter_sensitive_data('<TRACKER_TOKEN>') { ENV['PIVOTAL_TOKEN'] }
  end
end
