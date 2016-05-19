$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blueprint/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blueprint"
  s.version     = Blueprint::VERSION
  s.authors     = ["Jakub Hozak"]
  s.email       = ["jakub.hozak@gmail.com"]
  s.homepage    = "http://github.com/hakubjozak/blueprint"
  s.summary     = "Opiniated admin scaffolding on top of Rails"
  s.description = "Opiniated admin scaffolding on top of Rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails" #, ">= 5.0.0.rc1", "< 5.1"

  s.add_development_dependency "sqlite3"
end
