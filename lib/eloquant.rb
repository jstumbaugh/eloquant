require "eloquant/version"
require "eloquant/errors"

require "eloquant/concerns/connection"
require "eloquant/concerns/authentication"

module Eloquant
  class Client
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
      @host        = options.fetch(:host, "https://login.eloqua.com")

      @options = options

      set_host_url
    end
  end
end
