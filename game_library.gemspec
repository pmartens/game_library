$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "game_library/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "game_library"
  s.version     = GameLibrary::VERSION
  s.authors     = ["Pieter Martens"]
  s.email       = ["pieter@cg.nl"]
  s.homepage    = "http:\\www.cg.nl"
  s.summary     = "Game library to make simple Ruby/Rails games."
  s.description = "Description of GameLibrary."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.1"

  s.add_development_dependency "sqlite3"
end
