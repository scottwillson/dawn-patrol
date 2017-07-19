ENV["RAILS_ENV"] ||= "test"
require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "sucker_punch/testing/inline"
require "capybara/rails"
require "spec_helpers/tenant"

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Ensure that if we are running js tests, we are using latest webpack assets
  # This will use the defaults of :js and :server_rendering meta tags
  ReactOnRails::TestHelper.configure_rspec_to_compile_assets(config)

  config.infer_spec_type_from_file_location!
  config.include ActiveSupport::Testing::TimeHelpers
  config.include SpecHelpers::Tenant

  ReactOnRails::TestHelper.configure_rspec_to_compile_assets(config, :requires_webpack_assets)
  config.define_derived_metadata(file_path: %r{spec/(features|requests)}) do |metadata|
    metadata[:requires_webpack_assets] = true
  end

  config.before(:each) do
    set_current_association_to_default
  end

  config.after(:each) do
    reset_current_association_to_nil
  end
end
