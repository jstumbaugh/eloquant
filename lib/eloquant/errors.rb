module Eloquant
  module Errors
    class Error < StandardError
    end

    def self.create_class
      Class.new(Error)
    end

    Unknown            = create_class
    EmptyResponse      = create_class
    AuthorizationError = create_class
    BulkExportCreationError = create_class

    RESPONSE_CODE_TO_ERROR = {}.freeze

    RESPONSE_CODE_TO_ERROR.values.each do |class_name|
      const_set(class_name, create_class)
    end

    def self.find_by_response_code(response_code)
      const_get(RESPONSE_CODE_TO_ERROR.fetch(response_code, "Error"))
    end
  end
end
