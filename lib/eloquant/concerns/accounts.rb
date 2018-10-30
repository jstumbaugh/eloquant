module Eloquant
  module Accounts
    def describe_accounts
      describe_endpoint("accounts")
    end

    def describe_accounts_csv
      describe_endpoint_csv("accounts")
    end

    def number_of_accounts
      count_endpoint("accounts")
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
  end
end
