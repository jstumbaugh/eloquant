module Eloquant
  module Contacts
    def describe_contacts
      get("/api/bulk/2.0/contacts/fields")
    end

    def describe_contacts_csv(params = {})
      get("/api/bulk/2.0/contacts/fields", params, csv_custom_headers)
    end

    def number_of_contacts
      count_endpoint("contacts")
    end

    def get_contact(eloqua_external_id)
      params = {
        search: "ContactIDExt='#{eloqua_external_id}'",
        depth:  "complete",
      }

      get("/api/rest/1.0/data/contacts", params)
    end

    def create_bulk_contact_export(params = {})
      create_bulk_export("contacts", params)
    end

    def list_contact_exports
      list_bulk_exports("contacts")
    end

    def delete_contact_export(id:)
      delete_bulk_export("contacts", id)
    end
  end
end
