require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InfinityInterceptor
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end

  Aws.config.update({region: 'us-east-1',
    credentials: Aws::Credentials.new('AKIAZMAW3JF37ACRNB6W', 'y7Z4k+n1h7QvDq3r/eikeXMKF+qKaAqP02ZFxr4X')})

end
