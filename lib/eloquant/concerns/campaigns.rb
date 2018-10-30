module Eloquant
  module Campaigns
    def describe_campaigns
      describe_endpoint(campaigns)
    end

    def describe_campaigns_csv
      describe_endpoint_csv(campaigns)
    end

    def number_of_campaigns
      get_campaigns(count: 1).try(:[], :total)
    end

    def get_campaigns(page: nil, depth: :minimal, count: nil)
      params = {}
      params[:page]  = page  if !page.nil?
      params[:depth] = depth if !depth.nil?
      params[:count] = count if !count.nil?

      get("/api/rest/2.0/assets/campaigns", params)
    end

    private

      def campaigns
        "campaigns"
      end
  end
end
