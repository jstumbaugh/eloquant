module Eloquant
  module Opportunities
    def describe_opportunities
      describe_endpoint("opportunities")
    end

    def describe_opportunities_csv
      describe_endpoint_csv("opportunities")
    end
  end
end
