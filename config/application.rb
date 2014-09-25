require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Therealreal
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework      :rspec
      g.fixture_replacement :factory_girl

      g.view_specs          false
      g.helper_specs        false

      g.javascripts         false
      g.stylesheets         false
    end
  end
end
