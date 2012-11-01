$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "s3_fileupload_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "s3_fileupload_rails"
  s.version     = S3FileuploadRails::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of S3FileuploadRails."
  s.description = "TODO: Description of S3FileuploadRails."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "> 3.2.0"
  # s.add_dependency "jquery-rails"
  s.add_dependency "jquery-fileupload-rails"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency "terminal-notifier-guard"
  s.add_development_dependency "rb-fsevent"
end
