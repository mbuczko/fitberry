require 'resque'
require 'resque_scheduler'

config = YAML.load_file(Rails.root.join('config', 'resque.yml'))
schedule = YAML.load_file(Rails.root.join('config', 'schedule.yml'))

# configure redis connection
Resque.redis = config[Rails.env]

# configure the schedule
Resque.schedule = schedule
