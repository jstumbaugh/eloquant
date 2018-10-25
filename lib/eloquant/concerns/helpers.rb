module Eloquant
  module Helpers
    def csv_custom_headers
      { "Content-Type" => "text/csv" }
    end

    def json_custom_headers
      { "Content-Type" => "application/json" }
    end

    def json_post(path, params)
      post(path, JSON.generate(params), json_custom_headers)
    end
  end
end
