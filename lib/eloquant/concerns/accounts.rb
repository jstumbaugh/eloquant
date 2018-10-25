module Eloquant
  module Accounts
    def describe_accounts
      get("/api/bulk/2.0/accounts/fields")
    end

    def describe_accounts_csv(params = {})
      get("/api/bulk/2.0/accounts/fields", params, csv_custom_headers)
    end
  end
end
