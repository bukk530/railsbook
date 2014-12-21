$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "railsbook/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "railsbook"
  s.version     = RailsBook::VERSION
  s.authors     = ["bukk530"]
  s.email       = [""]
  s.homepage    = "https://github.com/bukk530/railsbook"
  s.summary     = "Rails4 Facebook connect"
  s.description = "Rails4 Facebook connect"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  
end
