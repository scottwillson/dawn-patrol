source "https://rubygems.org"

gem "rails", ">= 5.0.0", "< 5.1"
gem "pg"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.1.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem "therubyracer", platforms: :ruby

gem "jquery-rails"
gem "turbolinks", "~> 5.x"
gem "jbuilder", "~> 2.5"
gem "bcrypt", "~> 3.1.7"
gem "react-rails"
gem "bootstrap", "~> 4.0.0.alpha3"
gem "mysql2"
gem "acts_as_tenant", git: "https://github.com/ErwinM/acts_as_tenant", ref: "960d3df"
gem "default_value_for", github: "FooBarWidget/default_value_for"

group :development, :test do
  gem "byebug", platform: :mri
  gem "rspec", ">= 3.5.0.beta2"
  gem "rspec-rails", "3.5.0.beta4"
end

group :development do
  gem "capistrano-rails"
  gem "web-console"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara"
  gem "database_cleaner"
  gem "poltergeist"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

source "https://rails-assets.org" do
  gem "rails-assets-moment"
  gem "rails-assets-query"
  gem "rails-assets-tether", ">= 1.1.0"
end
