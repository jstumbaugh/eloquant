require "eloquant/version"
require "eloquant/errors"

require "eloquant/concerns/connection"
require "eloquant/concerns/authentication"

module Eloquant
  class Client
    DEFAULT_HOST_URL = "https://login.eloqua.com".freeze

    include Connection
    include Authentication

    def initialize(options = {})
      # Required
      @username      = options.fetch(:username)
      @sitename      = options.fetch(:sitename)
      @password      = options.fetch(:password)

      # Optional
      @max_retries = options.fetch(:max_retries, 10)
      @connection  = options.fetch(:connection, nil)
      @debug       = options.fetch(:debug, true)
      @host        = options.fetch(:host, DEFAULT_HOST_URL)

      @options = options
    end

    %i(get post).each do |http_method|
      define_method(http_method) do |path, payload = {}, &block|
        set_host_url_if_default

        response = connection.send(http_method, path, payload) do |request|
          add_authorization(request)

          block.call(request) unless block.nil?
        end

        response.body
      end
    end

    def set_host_url_if_default
      if @host == DEFAULT_HOST_URL
        set_host_url_to_clients_url
      end
    end
  end
end
