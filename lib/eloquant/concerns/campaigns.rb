module Eloquant
  module Campaigns
    def describe_campaigns
      describe_endpoint(campaigns)
    end

    def describe_campaigns_csv
      describe_endpoint_csv(campaigns)
    end

    private

      def campaigns
        "campaigns"
      end
  end
end
