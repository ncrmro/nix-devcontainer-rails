require_relative 'boot'

require 'rails'
require 'action_controller/railtie'

module NixDevcontainerRails
  class Application < Rails::Application
    config.load_defaults 7.1
    config.api_only = true

    # Only loads a smaller set of middleware suitable for API only apps.
    config.middleware.use ActionDispatch::Flash
  end
end
