# frozen_string_literal: true

require 'faraday'
require 'oj'
require_relative '../errors'

module OauthClient
  module Plugins
    module Google
      BASE_URL = 'https://oauth2.googleapis.com/tokeninfo'

      def self.register(access_token: nil)
        request = Faraday.new(
          url: BASE_URL,
          params: {
            id_token: access_token
          },
          headers: { 'Content-Type' => 'application/json' }
        )
        data = Oj.load(request.get.body, symbol_keys: true)
        raise OuathException, data[:error_description] if data[:error_description].present?

        data
      end
    end

    register_plugin(:google, Google)
  end
end
