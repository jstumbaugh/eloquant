module Eloquant
  module Authentication
    def add_authorization(request)
      request.headers["Authorization"] = "Basic #{encoded_sitename_username_and_password}"
    end

    def username_and_sitename
      "#{@sitename}\\#{@username}"
    end

    def encoded_sitename_username_and_password
      Base64.encode64("#{@sitename}\\#{@username}:#{@password}")
    end

    def set_host_url
      @host = host_information[:urls][:base]

      reload_connection
    end

    def host_information
      @host_information ||= connection.get("/id") do |request|
        add_authorization(request)
      end.body
    end
  end
end
