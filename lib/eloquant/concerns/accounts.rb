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
      create_bulk_export("accounts", params)
    end

    def list_account_exports
      list_bulk_exports("accounts")
    end

    # ID is the digits of the URI
    def delete_account_export(id:)
      delete_bulk_export("accounts", id)
    end

    def number_of_accounts
      count_endpoint("accounts")
    end
  end
end
