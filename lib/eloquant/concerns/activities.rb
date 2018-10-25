module Eloquant
  module Activities
    def describe_activities
      get("/api/bulk/2.0/activities/fields")
    end

    def describe_activities_csv(params = {})
      get("/api/bulk/2.0/activities/fields", params, csv_custom_headers)
    end
  end
end
