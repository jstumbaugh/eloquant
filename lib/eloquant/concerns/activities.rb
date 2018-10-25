module Eloquant
  module Activities
    def describe_activities
      get("/api/bulk/2.0/activities/fields")
    end

    def describe_activities_csv(params = {}, custom_headers = {})
      custom_headers["Content-Type"] = "text/csv"

      get("/api/bulk/2.0/activities/fields", params, custom_headers)
    end
  end
end
