require_relative 'client'
require_relative 'entity'
require_relative 'project'

module RTrail
  # High-level API for TestRail
  class API
    def initialize(hostname, user, password)
      url = hostname.gsub(/\/$/, '') + '/index.php?/api/v2/'

      @client = RTrail::Client.new(url, user, password)

      # FIXME: This is a bit hinky, but works well
      RTrail::Entity.client = @client
    end
    attr_reader :client

    # Convenience methods for commonly-accessed entities

    def project(project_name)
      return Project.by_name(project_name)
    end

    def runs(project_name)
      project = Project.by_name(project_name)
      return project.runs
    end

    def cases(project_name, suite_name)
      project = Project.by_name(project_name)
      suite = project.suite_by_name(suite_name)
      return suite.cases
    end

  end # class API
end # module RTrail

