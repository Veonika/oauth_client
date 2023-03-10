# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oauth_client/version'

Gem::Specification.new do |s|
  s.name                  = 'oauth_client'
  s.version               = OauthClient::VERSION
  s.summary               = 'oauth api client'
  s.licenses              = ['MIT']
  s.description           = 'This gem provides plugins (apple, google, odnoklassniki, vkontakte) for user authentication validation.'
  s.authors               = ['Veronika Molchanova']
  s.email                 = 've_ro_na01@mail.ru'
  s.homepage              = 'https://github.com/Veonika/oauth-client'
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = Gem::Requirement.new('>= 2.7')
  s.extra_rdoc_files      = ['README.md']
  s.require_paths         = ['lib']

  s.files = Dir['README.md', 'LICENSE', 'CHANGELOG.md',
                'lib/**/*.rb', 'lib/**/*.rake', 'oauth_client.gemspec',
                '.github/*.md', 'Gemfile', 'Rakefile']

  s.add_dependency 'faraday', '~> 2.5'
  s.add_dependency 'oj', '~> 3.13'
  s.add_development_dependency 'codecov', '~> 0.2'
  s.add_development_dependency 'dotenv', '~> 2.5'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rails', '~> 7.0'
  s.add_development_dependency 'rake', '~> 13.0'
  s.metadata['rubygems_mfa_required'] = 'true'
end
