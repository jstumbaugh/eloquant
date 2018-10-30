module Eloquant
  module CampaignResponses
    def describe_campaign_responses
      describe_endpoint(campaign_responses)
    end

    def describe_campaign_responses_csv
      describe_endpoint_csv(campaign_responses)
    end

    private

      def campaign_responses
        "campaignResponses"
      end
  end
end
