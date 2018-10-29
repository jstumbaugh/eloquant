module Eloquant
  module Activities
    def describe_activities
      describe_endpoint("activities")
    end

    def describe_activities_csv
      describe_endpoint_csv("activities")
    end
  end
end
