Gem::Specification.new do |s|
  s.name = "rtrail"
  s.version = "0.0.3"
  s.summary = "Ruby object wrapper for TestRail API"
  s.description = <<-EOS
    RTrail wraps the TestRail API v2.0 in Ruby objects
  EOS
  s.authors = ["Eric Pierce"]
  s.email = "epierce@automation-excellence.com"
  s.homepage = "http://github.com/a-e/rtrail"
  s.platform = Gem::Platform::RUBY
  s.license = 'MIT'

  s.add_dependency 'hashie', '~> 3.3'

  # Basic utilities
  s.add_development_dependency 'rake', '~> 10.3'
  s.add_development_dependency 'pry', '~> 0.10'

  # For testing
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rspec-autotest', '~> 1.0'
  s.add_development_dependency 'ZenTest', '~> 4.10'

  # Mock webapp to support testing
  s.add_development_dependency 'sinatra', '~> 1.4'
  s.add_development_dependency 'sinatra-contrib', '~> 1.4'
  s.add_development_dependency 'thin', '~> 1.6'

  # For test coverage
  s.add_development_dependency 'simplecov', '~> 0.9'
  s.add_development_dependency 'coveralls', '~> 0.7'

  # For documentation and markdown support
  s.add_development_dependency 'yard', '~> 0.8'
  s.add_development_dependency 'rdiscount', '~> 2.1'

  # Others
  s.add_development_dependency 'yajl-ruby', '~> 1.2'

  # Files to distribute
  s.files = `git ls-files`.split("\n")

  s.require_path = 'lib'
end
