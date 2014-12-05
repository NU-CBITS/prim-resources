source 'https://rubygems.org'

gem 'rails', '~> 4.1.8'
gem 'bcrypt'
gem 'pg'
gem 'active_model_serializers', '~> 0.9'
gem 'hashids'

group :development, :test do
  gem 'rspec-rails', '~> 3.1'
end

group :development do
  gem 'spring'
  gem 'capistrano', '~> 3.2', require: false
  gem 'capistrano-rails', '~> 1.1', require: false
  gem 'capistrano-rvm', '~> 0.1', require: false
  gem 'capistrano-bundler', '~> 1.1'
  gem 'rubocop'
  gem 'brakeman'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
end

group :staging, :production do
  # email exceptions
  gem 'exception_notification'
end
