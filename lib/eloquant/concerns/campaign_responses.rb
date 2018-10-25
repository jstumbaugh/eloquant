module Eloquant
  module CampaignResponses
    def describe_campaign_responses
      get("/api/bulk/2.0/campaignResponses/fields")
    end

    def describe_campaign_responses_csv(params = {})
      get("/api/bulk/2.0/campaignResponses/fields", params, csv_custom_headers)
    end
  end
end
