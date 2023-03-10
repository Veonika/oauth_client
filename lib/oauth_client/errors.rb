# frozen_string_literal: true

# Module for handling responses
module OauthClient
  # An exception raised by handler when given a response with an error.
  class OuathException < StandardError
    # An error code.
    # @return [Fixnum]
    attr_reader :code

    # @return [String]
    attr_reader :body

    # An exception is initialized by the data from response mash.
    # @param [Hash] data Error data.
    attr_reader :access_error

    def initialize(response)
      @code = 403
      @body = response
      super
    end
  end
end
