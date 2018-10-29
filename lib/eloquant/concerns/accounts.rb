module Eloquant
  module Accounts
    def describe_accounts
      get("/api/bulk/2.0/accounts/fields")
    end

    def describe_accounts_csv(params = {})
      get("/api/bulk/2.0/accounts/fields", params, csv_custom_headers)
    end

    def get_account(eloqua_external_id, depth: :complete)
      params = {
        search: "CompanyIDExt='#{eloqua_external_id}'",
        depth: depth,
      }

      get("/api/rest/1.0/data/accounts", params)
    end

    def create_bulk_account_export(params = {})
      response   = create_account_export(params)
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

    def get_export_data(sync_uri, offset: nil)
      params = {}
      params[:offset] = offset if offset

      get("/api/bulk/2.0#{sync_uri}/data", params)
    end

    def list_account_exports
      get("/api/bulk/2.0/accounts/exports")
    end

    # ID is the digits of the URI
    def delete_account_export(id:)
      delete("/api/bulk/2.0/accounts/exports/#{id}")
    end

    def number_of_accounts
      get("/api/rest/1.0/data/accounts", count: 1).try(:[], :total)
    end

    private

      # Need a `name` and a `fields` list
      def create_account_export(name: "Eloquant Account Export", fields: {})
        params = {
          name:   name,
          fields: fields,
        }

        json_post("/api/bulk/2.0/accounts/exports", params)
      end

      def enqueue_export(export_uri)
        params = { syncedInstanceUri: export_uri }

        json_post("/api/bulk/2.0/syncs", params)
      end

      def check_export_status(sync_uri)
        get("/api/bulk/2.0#{sync_uri}")
      end
  end
end
