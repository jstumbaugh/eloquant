module Eloquant
  module Helpers
    def csv_custom_headers
      { "Content-Type" => "text/csv" }
    end

    def json_custom_headers
      { "Content-Type" => "application/json" }
    end

    def json_post(path, params)
      post(path, JSON.generate(params), json_custom_headers)
    end

    def count_endpoint(endpoint)
      get("/api/rest/1.0/data/#{endpoint}", count: 1).try(:[], :total)
    end

    def describe_endpoint(endpoint)
      get("/api/bulk/2.0/#{endpoint}/fields")
    end

    def describe_endpoint_csv(endpoint, params = {})
      get("/api/bulk/2.0/#{endpoint}/fields", params, csv_custom_headers)
    end

    def create_bulk_export(endpoint, params)
      response = initialize_bulk_export(endpoint, params)

      if response.has_key?(:failures)
        fail Eloquant::Errors::BulkExportCreationError.new(response[:failures])
      end

      export_uri = response[:uri]

      status_response = enqueue_export(export_uri)
      sync_uri        = status_response[:uri]

      status = status_response[:status]

      while status != "success"
        sleep(10)

        status_response = check_export_status(sync_uri)
        status          = status_response[:status]
      end

      sync_uri
    end

    def initialize_bulk_export(endpoint, name: nil, fields: {}, filter: nil)
      params = {
        name:   name || "Eloquant #{endpoint.capitalize} Bulk Export",
        fields: fields,
      }
      params[:filter] = filter if !filter.nil?

      json_post("/api/bulk/2.0/#{endpoint}/exports", params)
    end

    def enqueue_export(export_uri)
      params = { syncedInstanceUri: export_uri }

      json_post("/api/bulk/2.0/syncs", params)
    end

    def check_export_status(sync_uri)
      get("/api/bulk/2.0#{sync_uri}")
    end

    def get_export_data(sync_uri, offset: nil)
      params = {}
      params[:offset] = offset if offset

      get("/api/bulk/2.0#{sync_uri}/data", params)
    end

    def list_bulk_exports(endpoint)
      get("/api/bulk/2.0/#{endpoint}/exports")
    end
  end
end
