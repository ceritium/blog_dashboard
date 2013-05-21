$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blog_dashboard/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blog_dashboard"
  s.version     = BlogDashboard::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "BlogDashboard is a mountable blog dashboard for Rails apps with Mongodb as backend."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "jquery-rails"

  s.add_dependency 'mongoid'
  s.add_dependency 'bson_ext'
  s.add_dependency "haml-rails"

  s.add_dependency "twitter-bootstrap-rails"
  s.add_dependency 'formtastic'
  s.add_dependency 'formtastic-bootstrap'
  s.add_dependency 'kaminari'
  s.add_dependency "carrierwave"
  s.add_dependency "carrierwave-mongoid"
  s.add_dependency 'redactor-rails'
  s.add_dependency "mini_magick"

  s.add_dependency 'sass-rails',   '~> 3.2.3'
  s.add_dependency 'coffee-rails', '~> 3.2.1'
  s.add_dependency 'uglifier', '>= 1.0.3'

  s.add_development_dependency "simplecov"
  s.add_development_dependency "coveralls"
  s.add_development_dependency "capybara"
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'database_cleaner'

end
