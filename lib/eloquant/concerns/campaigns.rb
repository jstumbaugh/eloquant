module Eloquant
  module Campaigns
    def describe_campaigns
      get("/api/bulk/2.0/campaigns/fields")
    end

    def describe_campaigns_csv(params = {}, custom_headers = {})
      custom_headers["Content-Type"] = "text/csv"

      get("/api/bulk/2.0/campaigns/fields", params, custom_headers)
    end
  end
end
