require 'rake'
require 'rspec/core/rake_task'

ROOT_DIR = File.expand_path(File.dirname(__FILE__))
MOCK_APP = File.join(ROOT_DIR, 'mock', 'app.rb')

namespace :mock do
  desc "Start the mock TestRail app in the background"
  task :start do
    puts "Starting the mock TestRail app: #{MOCK_APP}"
    system("ruby #{MOCK_APP} &")
  end

  desc "Stop the mock TestRail app"
  task :stop do
    puts "Stopping the mock TestRail app..."
    begin
      Net::HTTP.get('localhost', '/shutdown', 8080)
    rescue EOFError
      # This is expected
      puts "Mock TestRail app stopped."
    end
  end
end

desc "Run spec tests (requires mock TestRail app to be running)"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = ['--color', '--format doc']
end

desc "Start the mock TestRail app, run specs, then stop the mock app"
task :test do
  begin
    Rake::Task['mock:start'].invoke
    Rake::Task['spec'].invoke
  ensure
    Rake::Task['mock:stop'].invoke
  end
end

task :default => [:test]
