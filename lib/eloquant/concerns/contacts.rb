module Eloquant
  module Contacts
    def describe_contacts
      get("/api/bulk/2.0/contacts/fields")
    end

    def describe_contacts_csv(params = {})
      get("/api/bulk/2.0/contacts/fields", params, csv_custom_headers)
    end
  end
end
