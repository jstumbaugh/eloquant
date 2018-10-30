module Eloquant
  module Contacts
    def describe_contacts
      describe_endpoint(contacts)
    end

    def describe_contacts_csv
      describe_endpoint_csv(contacts)
    end

    def number_of_contacts
      count_endpoint(contacts)
    end

    def get_contact(eloqua_external_id)
      params = {
        search: "ContactIDExt='#{eloqua_external_id}'",
        depth:  "complete",
      }

      get("/api/rest/1.0/data/contacts", params)
    end

    def create_bulk_contact_export(params = {})
      create_bulk_export(contacts, params)
    end

    def list_contact_exports
      list_bulk_exports(contacts)
    end

    private

      def contacts
        "contacts"
      end
  end
end
