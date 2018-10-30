module Eloquant
  module Activities
    def describe_activities
      describe_endpoint(activities)
    end

    def describe_activities_csv
      describe_endpoint_csv(activities)
    end

    # Filter is the name of the activity type
    def create_bulk_activity_export(fields:, filter:)
      params = {
        fields: fields,
        filter: filter,
      }

      create_bulk_export(activities, params)
    end

    def list_activity_exports
      list_bulk_exports(activities)
    end

    def delete_activity_export(id:)
      delete_bulk_export(activities, id)
    end

    private

      def activities
        "activities"
      end
  end
end
