# frozen_string_literal: true

require 'oauth_client/plugins'
require 'oauth_client/version'

# Settings
module OauthClient
  @opts = {}

  def self.plugin(plugin, **opts)
    plugin = Plugins.load_plugin(plugin) if plugin.is_a?(Symbol)
    Plugins.configure(plugin, self, **opts)
    plugin
  end

  def self.opts
    @opts
  end
end
