# frozen_string_literal: true

require 'faraday'
require 'oj'
require_relative '../errors'

module OauthClient
  module Plugins
    module Odnoklassniki
      BASE_URL = 'https://api.ok.ru/fb.do'

      def self.configure(uploader, **opts)
        uploader.opts[:odnoklassniki] ||= {}
        uploader.opts[:odnoklassniki].merge!(opts)
      end

      def self.register(access_token: nil)
        request = Faraday.new(
          url: BASE_URL,
          params: {
            application_key: OauthClient.opts[:odnoklassniki][:key],
            method: 'users.getCurrentUser',
            access_token: access_token
          },
          headers: { 'Content-Type' => 'application/json' }
        )
        data = Oj.load(request.get.body, symbol_keys: true)
        raise OuathException, data[:error_msg] if data[:error_msg].present?

        data
      end
    end

    register_plugin(:odnoklassniki, Odnoklassniki)
  end
end
