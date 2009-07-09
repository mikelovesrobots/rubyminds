require 'app_config'

::AppConfig = ApplicationConfig.init(Rails.root.to_s + "/config/app_config.yml", Rails.env)