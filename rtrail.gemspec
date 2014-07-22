Gem::Specification.new do |s|
  s.name = "rtrail"
  s.version = "0.0.1"
  s.summary = "Ruby object wrapper for TestRail API"
  s.description = <<-EOS
    RTrail wraps the TestRail API v2.0 in Ruby objects
  EOS
  s.authors = ["Eric Pierce"]
  s.email = "epierce@automation-excellence.com"
  s.homepage = "http://github.com/a-e/rtrail"
  s.platform = Gem::Platform::RUBY

  s.add_dependency 'hashie'

  # Basic utilities
  s.add_development_dependency 'rake'
  s.add_development_dependency 'pry'

  # For testing
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-autotest'
  s.add_development_dependency 'ZenTest'

  # Mock webapp to support testing
  s.add_development_dependency 'sinatra'
  s.add_development_dependency 'sinatra-contrib'
  s.add_development_dependency 'thin'

  # For test coverage
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'coveralls'

  # For documentation and markdown support
  s.add_development_dependency 'yard'
  s.add_development_dependency 'rdiscount'

  # Others
  s.add_development_dependency 'yajl-ruby'

  # Files to distribute
  s.files = `git ls-files`.split("\n")

  s.require_path = 'lib'
end
