Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    url_options = Settings.routes.web.url_options
    origins "#{url_options.protocol}://" + [url_options.host, url_options.port].compact.join(':')

    resource '*', headers: :any, methods: :any
  end
end
