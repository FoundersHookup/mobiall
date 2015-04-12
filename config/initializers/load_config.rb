# config/initializers/application_settings.rb
# ========================
# Tells Rails to load our ApplicationSettings module and then
# populates our config class variable with data from our application_settings.yml file
# From here on in, we should be able to call:
#
#    ApplicationSettings.config['email_notifications']
#
# and have it return our config option...

require "#{Dir.pwd}/lib/config.rb"
APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]