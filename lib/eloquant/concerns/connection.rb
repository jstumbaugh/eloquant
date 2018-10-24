require "eloquant/faraday_middleware"

module Eloquant
  module Connection
    def connection
      @connection ||= init_connection
    end

    def reload_connection
      @connection = init_connection
    end

    def init_connection
      Faraday.new(url: @host) do |conn|
        conn.request :multipart
        conn.request :url_encoded

        conn.request :retry, max: 10, interval: 0.05,
          interval_randomness: 0.5, backoff_factor: 2,
          exceptions: [Errno::ETIMEDOUT, "Timeout::Error",
                      ::Faraday::Error::TimeoutError,
                      ::Faraday::ConnectionFailed]

        conn.response :logger if @debug
        conn.response :eloquant, content_type: /\bjson$/

        conn.options.timeout      = @options[:read_timeout] if @options.key?(:read_timeout)
        conn.options.open_timeout = @options[:open_timeout] if @options.key?(:open_timeout)

        conn.adapter Faraday.default_adapter
      end
    end
  end
end
