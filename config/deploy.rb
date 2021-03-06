set :application, "fitberry"
set :repository,  "git@devnode.pl:repo/fitberry.git"
set :branch, "master"
set :keep_releases, 5


# Code Repository
# =========
set :scm, :git
set :scm_verbose, true
set :deploy_via, :remote_cache

# Remote Server
# =============
set :use_sudo, false
ssh_options[:forward_agent] = true

# Bundler
# -------
require 'bundler/capistrano'
set :bundle_flags, "--deployment --binstubs"
set :bundle_without, [:test, :development, :deploy]

# Rbenv
# -----
default_run_options[:shell] = '/bin/bash --login'


# Rails: Asset Pipeline
# ---------------------
#load 'deploy/assets'

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts


# Server specific
# ----------------
set :user, "deploy"
server "testbox", :web, :app, :db, :primary => true
set :deploy_to, "/home/apps/#{application}"
set :rails_env, "production"


# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do
    run "sudo sv up fitberry"
  end
  task :stop do
    run "sudo sv down fitberry"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "sudo sv restart fitberry"
  end
end