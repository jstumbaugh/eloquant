module Eloquant
  module Contacts
    def describe_contacts
      get("/api/bulk/2.0/contacts/fields")
    end

    def describe_contacts_csv(params = {}, custom_headers = {})
      custom_headers["Content-Type"] = "text/csv"

      get("/api/bulk/2.0/contacts/fields", params, custom_headers)
    end
  end
end
