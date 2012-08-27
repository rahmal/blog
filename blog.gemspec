$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blog/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name         = 'blog'
  s.version      = Blog::VERSION
  s.authors      = ['Rahmal Conda']
  s.email        = ['rahmal@rahmalconda.com']
  s.homepage     = 'http://www.rahmalconda.com'
  s.summary      = 'A Rails Engine that adds a simple blogging engine onto an existing Rails App.'
  s.description  = "Blog is a Rails Engine that adds a simple blogging engine onto an existing Rails App. It is for anyone who has an existing Rails app that they use for their primary website or web application and would like to add a blog without deploying a separate blogging application, or building one from scratch. I built MiniBlog to add a blog to my own personal site, which I had already built.  It is perfect for personal blogging, if you don't need a full-featured blogging or cms application."

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
  s.test_files   = Dir["spec/**/*"]

  s.add_dependency 'rails',         '3.2.6'
  s.add_dependency 'jquery-rails' #, '~> 1.0'
  s.add_dependency 'sass-rails',    '~> 3.2.3'
  s.add_dependency 'coffee-rails',  '~> 3.2.1'
  s.add_dependency 'kaminari'     #, '~> 0.12.4'
  s.add_dependency 'cancan'       #, '~> 1.6'
  s.add_dependency 'simple_form'  #, '~> 1.4'
  s.add_dependency 'state_machine', '~> 1.0.0'
  s.add_dependency 'rdiscount',     '~> 1.6'
  s.add_dependency 'sanitize',      '~> 2.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'devise'
  s.add_development_dependency 'steak'
  s.add_development_dependency 'foreman'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'generator_spec'
  s.add_development_dependency 'fakeweb'
  s.add_development_dependency 'vcr'   #,             '>= 2.0.0.beta2'
# s.add_development_dependency 'capybara-webkit', '~> 0.6.1'
# s.add_development_dependency 'machinist' (see Gemfile)
# s.add_development_dependency 'pygments' (see Gemfile)
end
