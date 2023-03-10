# frozen_string_literal: true

require 'faraday'
require 'oj'
require_relative '../errors'

module OauthClient
  module Plugins
    module Vkontakte
      BASE_URL = 'https://api.vk.com/method/account.getProfileInfo'
      VERSION = '5.131'

      def self.register(access_token: nil)
        request = Faraday.new(
          url: BASE_URL,
          params: {
            access_token: access_token,
            v: VERSION
          },
          headers: { 'Content-Type' => 'application/json' }
        )
        data = Oj.load(request.get.body, symbol_keys: true)
        raise OuathException, data[:error][:error_msg] if data[:error].present?

        data[:response]
      end
    end

    register_plugin(:vkontakte, Vkontakte)
  end
end
