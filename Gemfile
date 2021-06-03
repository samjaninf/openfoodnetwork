# frozen_string_literal: true

source 'https://rubygems.org'
ruby "2.5.9"
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

gem 'rails', '~> 6.0.3.6'

gem 'activemerchant', '>= 1.78.0'
gem 'angular-rails-templates', '>= 0.3.0'
gem 'awesome_nested_set'
gem 'ransack', '2.4.1'
gem 'responders'
gem 'sass', '~> 3.4.0' # this restriction originates from foundation-rails's version
gem 'sass-rails', '< 5.1.0' # this restriction originates from the compass-rails's version

gem 'i18n'
gem 'i18n-js', '~> 3.8.3'
gem 'rails-i18n'
gem 'rails_safe_tasks', '~> 1.0'

gem "activerecord-import"
gem "db2fog", github: "openfoodfoundation/db2fog", branch: "rails-6"
gem "fog-aws", "~> 2.0" # db2fog does not support v3

gem "catalog", path: "./engines/catalog"
gem 'dfc_provider', path: './engines/dfc_provider'
gem "order_management", path: "./engines/order_management"
gem 'web', path: './engines/web'

gem 'activerecord-postgresql-adapter'
gem 'pg', '~> 1.2.3'

gem 'acts_as_list', '1.0.4'
gem 'cancancan', '~> 1.15.0'
gem 'ffaker'
gem 'highline', '2.0.3' # Necessary for the install generator
gem 'json'
gem 'monetize', '~> 1.11'
gem 'paranoia', '~> 2.4'
gem 'state_machines-activerecord'
gem 'stringex', '~> 2.8.5'

gem 'paypal-sdk-merchant', '1.117.2'
gem 'stripe'

gem 'devise'
gem 'devise-encryptable'
gem 'devise-token_authenticatable'
gem 'jwt', '~> 2.2'
gem 'oauth2', '~> 1.4.7' # Used for Stripe Connect

gem 'daemons'
gem 'delayed_job_active_record'

gem 'kaminari', '~> 1.2.1'

gem 'andand'
gem 'angularjs-rails', '1.5.5'
gem 'aws-sdk', '1.67.0'
gem 'bugsnag'
gem 'haml'
gem 'redcarpet'

gem 'actionpack-action_caching'
# AMS 0.9.x and 0.10.x are very different from 0.8.4 and the upgrade is not straight forward
#   AMS is deprecated, we will introduce an alternative at some point
gem "active_model_serializers", "0.8.4"
gem 'activerecord-session_store'
gem 'acts-as-taggable-on', '~> 7.0'
gem 'angularjs-file-upload-rails', '~> 2.4.1'
gem 'custom_error_message', github: 'jeremydurham/custom-err-msg'
gem 'dalli'
gem 'figaro'
gem 'geocoder'
gem 'gmaps4rails'
gem 'mimemagic', '> 0.3.5'
gem 'paper_trail', '~> 10.3.1'
gem 'paperclip', '~> 3.4.1'
gem 'rack-rewrite'
gem 'rack-ssl', require: 'rack/ssl'
gem 'roadie-rails'

gem 'redis', '>= 4.0', require: ['redis', 'redis/connection/hiredis']
gem 'hiredis'
gem 'sidekiq'
gem 'sidekiq-scheduler'

gem 'combine_pdf'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

gem 'immigrant'
gem 'roo', '~> 2.8.3'

gem 'whenever', require: false

gem 'test-unit', '~> 3.4'

gem 'coffee-rails', '~> 5.0.0'
gem 'compass-rails'

gem 'mini_racer', '0.4.0'

gem 'uglifier', '>= 1.0.3'

gem 'angular_rails_csrf'
gem 'foundation-icons-sass-rails'

gem 'foundation-rails', '= 5.5.2.1'

gem 'jquery-migrate-rails'
gem 'jquery-rails', '4.4.0'
gem 'jquery-ui-rails', '~> 4.2'
gem 'select2-rails', '~> 3.4.7'
# Thor v0.20 works with both select2-rails 3.4.7 and railties 6.0.3.6
#   To upgrade to thor v1 we need to upgrade select2-rails to v3.5 which requires some work
gem 'thor', '~> 0.20'

gem 'ofn-qz', github: 'openfoodfoundation/ofn-qz', branch: 'ofn-rails-4'

gem 'good_migrations'

gem 'flipper'
gem 'flipper-active_record'
gem 'flipper-ui'

gem "view_component", require: "view_component/engine"

group :production, :staging do
  gem 'ddtrace'
  gem 'unicorn-worker-killer'
end

group :test, :development do
  # Pretty printed test output
  gem 'awesome_print'
  gem 'bullet'
  gem 'capybara'
  gem 'database_cleaner', require: false
  gem "factory_bot_rails", '6.2.0', require: false
  gem 'fuubar', '~> 2.5.1'
  gem 'json_spec', '~> 1.1.4'
  gem 'knapsack'
  gem 'letter_opener', '>= 1.4.1'
  gem 'rspec-rails', ">= 3.5.2"
  gem 'rspec-retry'
  gem 'rswag'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'timecop'
  gem 'unicorn-rails'
  gem 'webdrivers'
end

group :test do
  gem 'codecov', require: false
  gem 'simplecov', require: false
  gem 'test-prof'
  gem 'webmock'
  gem 'rails-controller-testing'
  gem 'pdf-reader'
  # See spec/spec_helper.rb for instructions
  # gem 'perftools.rb'
end

group :development do
  gem 'byebug'
  gem 'debugger-linecache'
  gem 'pry'
  gem 'pry-byebug'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'spring'
  gem 'spring-commands-rspec'

  gem "view_component_storybook", require: "view_component/storybook/engine"

  gem 'rack-mini-profiler', '< 3.0.0'
end
