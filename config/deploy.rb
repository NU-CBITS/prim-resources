# config valid only for Capistrano 3.1
lock '3.2.1'

# The name of the application on GitHub, as well as the folder in which it
# will be deployed.
set :application, 'prim-resources'
# The first part of the domain name. By convention, staging domains follow the
# pattern [domain_prefix]-staging.cbits.northwestern.edu, and production
# domains follow the pattern [domain-prefix].northwestern.edu.
set :domain_prefix, 'prim-resources'
# The version of MRI Ruby under which the application will run. Applications
# run behind Apache with Phusion Passenger.
set :rvm_ruby_version, '2.1.5'

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :linked_files is []
set :linked_files, [
  "config/database.yml",
  "config/environments/#{ fetch(:stage) }.rb",
  "config/initializers/secret_token.rb",
  "config/initializers/devise_secret_token.rb"]

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

require_relative 'deploy_shared.rb'
