module Eloquant
  module Campaigns
    def describe_campaigns
      get("/api/bulk/2.0/campaigns/fields")
    end

    def describe_campaigns_csv(params = {})
      get("/api/bulk/2.0/campaigns/fields", params, csv_custom_headers)
    end
  end
end
