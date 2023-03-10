# frozen_string_literal: true

require 'faraday'
require 'oj'
require_relative '../errors'

module OauthClient
  module Plugins
    module Apple
      APPLE_ISSUER = 'https://appleid.apple.com'
      APPLE_JWKS_URI = 'https://appleid.apple.com/auth/keys'
      JWT_RS256 = 'RS256'

      def self.register(access_token: nil)
        request = Faraday.new(url: APPLE_JWKS_URI)
        data = Oj.load(request.get.body, symbol_keys: true)
        raise OuathException unless data[:keys]

        payload = decode_token(access_token, data[:keys])
        raise OuathException unless payload

        payload
      end

      private

      def decode_token(access_token, public_keys)
        public_keys.each do |public_key|
          jwk = JWT::JWK.import(public_key)
          decoded_token = JWT.decode(
            access_token,
            jwk.public_key,
            public_key.present?,
            {
              algorithm: JWT_RS256,
              iss: APPLE_ISSUER,
              verify_iss: true
            }
          )
          return decoded_token.first
        rescue JWT::JWKError
          raise OuathException
        rescue JWT::ExpiredSignature
          raise OuathException
        rescue JWT::InvalidIssuerError
          raise OuathException
        rescue JWT::DecodeError
          nil # Try another public key.
        end

        false
      end
    end

    register_plugin(:apple, Apple)
  end
end
