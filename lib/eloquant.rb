require "eloquant/version"
require "eloquant/errors"

require "eloquant/concerns/authentication"
require "eloquant/concerns/connection"
require "eloquant/concerns/helpers"

require "eloquant/concerns/accounts"
require "eloquant/concerns/activities"
require "eloquant/concerns/campaign_responses"
require "eloquant/concerns/campaigns"
require "eloquant/concerns/contacts"
require "eloquant/concerns/custom_objects"
require "eloquant/concerns/events"
require "eloquant/concerns/external_activities"
require "eloquant/concerns/opportunities"

module Eloquant
  def self.client(options = {})
    Client.new(options)
  end

  class Client
    DEFAULT_HOST_URL = "https://login.eloqua.com".freeze

    include Authentication
    include Connection
    include Helpers

    include Accounts
    include Activities
    include CampaignResponses
    include Campaigns
    include Contacts
    include CustomObjects
    include Events
    include ExternalActivities
    include Opportunities

    def initialize(options = {})
      # Required
      @username = options.fetch(:username, ENV["ELOQUA_USERNAME"])
      @sitename = options.fetch(:sitename, ENV["ELOQUA_SITENAME"])
      @password = options.fetch(:password, ENV["ELOQUA_PASSWORD"])

      # Optional
      @max_retries = options.fetch(:max_retries, 10)
      @connection  = options.fetch(:connection, nil)
      @debug       = options.fetch(:debug, true)
      @logger      = options.fetch(:logger, nil)
      @host        = options.fetch(:host, DEFAULT_HOST_URL)

      @options = options
    end

    %i(get post).each do |http_method|
      define_method(http_method) do |path, payload = {}, custom_headers = {}, &block|
        set_host_url_if_default

        response = connection.send(http_method, path, payload) do |request|
          add_authorization(request)

          custom_headers.each do |key, value|
            request.headers[key] = value
          end

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
