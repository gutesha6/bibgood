source 'https://rubygems.org'
ruby '2.3.4'

gem 'rails', '~> 5.1'

gem 'bundler'
gem 'coffee-rails', '~> 4.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'sprockets', '>= 3.0.0'
gem 'sprockets-es6'
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
gem 'aws-ses', require: 'aws/ses'
gem 'bcrypt', '~> 3.1.7'
gem 'breadcrumbs_on_rails'
gem 'carrierwave-aws'
gem 'devise'
gem 'font-awesome-sass'
gem 'friendly_id'
gem 'hashid-rails'
gem 'high_voltage', '~> 3.0.0'
gem 'kaminari'
gem 'koala', '~> 2.2'
gem 'omniauth-facebook'
gem 'pundit'
gem 'simple_form', github: 'elsurudo/simple_form', branch: 'rails-5.1.0'
gem 'statesman'

gem 'honeybadger'
gem 'paper_trail'
gem 'paranoia', '~> 2.2'
gem 'redcarpet'

# Bootstrap
gem 'bootstrap', '~> 4.0.0.alpha3.1'

# Required for Bootstrap
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'dotenv-rails'
  gem 'letter_opener'
  gem 'pry-rails'

  gem 'factory_girl_rails'
  gem 'faker', github: 'stympy/faker'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'launchy'
  gem 'rubocop', require: false
  gem 'terminal-notifier-guard'
end

group :test, :darwin do
  gem 'rb-fsevent'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console'
end

group :test do
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-callback-matchers'
  gem 'shoulda-matchers'

  gem 'capybara-screenshot', github: 'mattheworiordan/capybara-screenshot'
  gem 'poltergeist'
  gem 'selenium-webdriver'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'rails_12factor', group: 'production'
gem 'tzinfo-data', platforms: %w[mingw mswin x64_mingw jruby]
