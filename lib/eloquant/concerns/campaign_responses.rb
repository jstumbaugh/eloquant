module Eloquant
  module CampaignResponses
    def describe_campaign_responses
      describe_endpoint("campaignResponses")
    end

    def describe_campaign_responses_csv
      describe_endpoint_csv("campaignResponses")
    end
  end
end
