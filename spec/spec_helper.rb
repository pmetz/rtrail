PROJECT_ROOT = File.expand_path('..', File.dirname(__FILE__))
SPEC_DIR = File.join(PROJECT_ROOT, 'spec')
MOCK_APP_URL = "http://localhost:8080/index.php?/api/v2/"

$LOAD_PATH.unshift(File.join(PROJECT_ROOT, 'lib'))

module SpecHelpers
end

RSpec.configure do |c|
  c.include SpecHelpers
end
