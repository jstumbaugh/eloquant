module Eloquant
  module Opportunities
    def describe_opportunities
      get("/api/bulk/2.0/opportunities/fields")
    end

    def describe_opportunities_csv(params = {}, custom_headers = {})
      custom_headers["Content-Type"] = "text/csv"

      get("/api/bulk/2.0/opportunities/fields", params, custom_headers)
    end
  end
end
