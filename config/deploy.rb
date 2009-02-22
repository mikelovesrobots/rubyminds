set :application, "rubyminds"
set :repository,  "git@github.com:mikelovesrobots/#{application}.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

set :deploy_to, "/mnt/sites/#{application}"

# Set to pull from the environment until I can figure out how to avoid
# publishing this.  Funny that ENV is safer than just writing it here.
set :user, ENV['RUBYMINDS_SERVER_USERNAME']
set :password, ENV['RUBYMINDS_SERVER_PASSWORD']

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :deploy_via, :remote_cache
set :branch, "master"
default_run_options[:pty] = true
set :ssh_options, { :forward_agent => true }

role :app, "#{application}.com"
role :web, "#{application}.com"
role :db,  "#{application}.com", :primary => true

# This is supposed to help with the setup task
set :use_sudo, false
