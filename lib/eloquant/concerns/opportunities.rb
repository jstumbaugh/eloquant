module Eloquant
  module Opportunities
    def describe_opportunities
      get("/api/bulk/2.0/opportunities/fields")
    end

    def describe_opportunities_csv(params = {})
      get("/api/bulk/2.0/opportunities/fields", params, csv_custom_headers)
    end
  end
end
