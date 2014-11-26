if defined?(Rack::Zippy)
  Rails.application.config.middleware.swap(ActionDispatch::Static, Rack::Zippy::AssetServer)
end
