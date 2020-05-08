require_relative 'boot'

require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BlogApp
  class Application < Rails::Application
    config.middleware.use "ResponseTimeCalculator"
    config.autoload_paths += %W(#{config.root}/lib)
  end
end
