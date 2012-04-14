$:.unshift File.expand_path("../lib", __FILE__)
require 'chute/version'

Gem::Specification.new do |s|
  s.name        = "chute"
  s.version     = Chute::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = "Gaurav Giri"
  s.email       = "gaurav@gauravgiri.com"
  s.homepage    = "https://github.com/chute/chute-ruby"
  s.summary     = "Chute assets for ActiveRecord"
  s.description = "Easy asset management with Chute for Rails apps"

  s.add_dependency('rails', '>= 3.0.0')
  s.add_dependency('httparty')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 1.9.2"
  s.date = File.mtime(__FILE__)
end
