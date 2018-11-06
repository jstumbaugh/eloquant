module Eloquant
  module Events
    def list_events
      get("/api/bulk/2.0/events")
    end
  end
end
