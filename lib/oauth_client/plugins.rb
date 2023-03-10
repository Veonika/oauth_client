# frozen_string_literal: true

require 'oauth_client/errors'

module OauthClient
  # Module in which all Shrine plugins should be stored. Also contains logic
  # for registering and loading plugins.
  module Plugins
    @plugins = {}

    # If the registered plugin already exists, use it. Otherwise, require it
    # and return it. This raises a LoadError if such a plugin doesn't exist,

    def self.load_plugin(name)
      unless @plugins[name]
        require "oauth_client/plugins/#{name}"
        raise OuathException, "plugin #{name} did not register itself correctly" unless @plugins[name]
      end

      @plugins[name]
    end

    # Delegate call to the plugin in a way that works across Ruby versions.
    def self.configure(plugin, uploader, **opts)
      return unless plugin.respond_to?(:configure)

      plugin.configure(uploader, **opts)
    end

    # Register the given plugin, so that it can be loaded using
    def self.register_plugin(name, mod)
      @plugins[name] = mod
    end
  end
end
