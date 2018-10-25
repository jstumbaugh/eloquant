module Eloquant
  module Accounts
    def describe_accounts
      get("/api/bulk/2.0/accounts/fields")
    end

    def describe_accounts_csv(params = {}, custom_headers = {})
      custom_headers["Content-Type"] = "text/csv"

      get("/api/bulk/2.0/accounts/fields", params, custom_headers)
    end
  end
end
