ENV["RAILS_ENV"] ||= "test"
require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "sucker_punch/testing/inline"
require "capybara/rails"
require "spec_helpers/tenant"

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include ActiveSupport::Testing::TimeHelpers
  config.include SpecHelpers::Tenant

  config.before(:each) do
    set_current_association_to_default
  end

  config.after(:each) do
    reset_current_association_to_nil
  end
end
