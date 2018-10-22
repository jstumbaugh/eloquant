require "eloquant/version"
require "eloquant/errors"

require "eloquant/concerns/connection"

module Eloquant
  class Client
    include Connection

    def initialize(options = {})
      @host          = options.fetch(:host)
      @client_id     = options.fetch(:client_id)
      @client_secret = options.fetch(:client_secret)
      @max_retries   = options.fetch(:max_retries, 10)
      @connection    = options.fetch(:connection)

      @options = options
    end
  end
end
