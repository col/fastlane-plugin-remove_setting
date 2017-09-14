# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/remove_setting/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-remove_setting'
  spec.version       = Fastlane::RemoveSetting::VERSION
  spec.author        = 'Colin Harris'
  spec.email         = 'col.w.harris@gmail.com'

  spec.summary       = 'Fastlane plugin to remove settings from an iOS settings bundle'
  spec.homepage      = 'https://github.com/col/fastlane-plugin-remove_setting'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*'] + %w[README.md LICENSE]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'plist', '~> 3.3'
  spec.add_dependency 'xcodeproj', '~> 1.4'
  spec.add_dependency 'fastlane-plugin-settings_bundle', '= 1.2.1'

  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'rake', '~> 12.1'
  spec.add_development_dependency 'rubocop', '~> 0.49'
  spec.add_development_dependency 'fastlane', '~> 2.55'
end
