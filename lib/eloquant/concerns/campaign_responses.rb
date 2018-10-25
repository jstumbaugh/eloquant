module Eloquant
  module CampaignResponses
    def describe_campaign_responses
      get("/api/bulk/2.0/campaignResponses/fields")
    end

    def describe_campaign_responses_csv(params = {}, custom_headers = {})
      custom_headers["Content-Type"] = "text/csv"

      get("/api/bulk/2.0/campaignResponses/fields", params, custom_headers)
    end
  end
end
