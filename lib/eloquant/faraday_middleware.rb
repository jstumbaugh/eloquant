require "faraday"

module Eloquant
  module FaradayMiddleware
    autoload :Response, "mrkt/faraday_middleware/response"
  end

  if Faraday::Middleware.respond_to?(:register_middleware)
    Faraday::Response.register_middleware eloquant: -> { Eloquant::FaradayMiddleware::Response }
  end
end
