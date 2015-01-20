source 'http://rubygems.org'

gem 'rails', '3.2.11'
gem 'jquery-rails'

gem 'fitgem', :git => 'git://github.com/whazzmaster/fitgem.git'

gem 'redis'
gem 'resque', :require => 'resque/server'
gem 'resque-scheduler'

gem 'devise'
gem 'omniauth-fitbit', :git => 'git://github.com/gardentree/omniauth-fitbit.git'
gem 'formtastic'
gem 'rabl'

gem 'activeadmin'
gem 'paperclip', "~> 3.0"
gem 'RedCloth'

gem 'pg'
gem 'gmaps4rails', :git => 'https://github.com/apneadiving/Google-Maps-for-Rails.git'

gem 'meta_search', '>= 1.1.0.pre'

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'sqlite3-ruby', '~> 1.3.0', :require => "sqlite3"
  gem 'awesome_print'
  gem 'pry-rails'
  gem 'guard-livereload'
  gem 'rb-fsevent'
end

group :development do
  gem 'meta_request', '0.2.0'
  gem 'better_errors'
  gem 'thin'
  gem 'rails-erd'
  gem 'capistrano'
end

group :production, :demo do
  gem 'passenger', '>= 4.0.0.rc4'
end

group :test do
  gem 'rspec'
  gem 'cucumber'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'capybara', :git => 'https://github.com/jnicklas/capybara.git'
  gem 'poltergeist', :git => 'https://github.com/brutuscat/poltergeist.git'
end
