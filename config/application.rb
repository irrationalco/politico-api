require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module ElectionApi
  class Application < Rails::Application
    config.api_only = true

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins Rails.application.secrets.client_host
        resource '*', headers: :any, methods: %i[get post options delete put]
      end
    end
  end
end
