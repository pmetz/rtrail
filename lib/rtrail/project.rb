require_relative 'entity'
require_relative 'suite'
require_relative 'run'
require_relative 'plan'

module RTrail
  class Project < Entity
    def self.all
      return client.get("get_projects")
    end

    def self.by_name(project_name)
      result = Project.all.find do |project|
        project.name == project_name
      end

      if result.nil?
        raise RTrail::NotFound.new("Project '#{project_name}' not found in TestRail")
      else
        return self.new(result)
      end
    end

    # Return a suite with the given name in the current project.
    def suite_by_name(suite_name)
      suite = self.suites.find do |s|
        s.name == suite_name
      end
      if suite.nil?
        raise RTrail::NotFound.new(
          "Suite '#{suite_name}' not found in project '#{self.data.name}'")
      end
      return suite
    end

    # Return a suite with the given name or id in the current project.
    def suite(suite_name_or_id)
      if is_id?(suite_name_or_id)
        return Suite.new(suite_name_or_id)
      else
        return suite_by_name(suite_name_or_id)
      end
    end

    def suite_id(suite_name_or_id)
      return self.suite(suite_name_or_id).id
    end

    def plans
      return get_entities(Plan, data.id)
    end

    def runs
      return get_entities(Run, data.id)
    end

    def suites
      return get_entities(Suite, data.id)
    end

    # Return an existing run with the given name, or create and
    # return a new run.
    def run(suite_name_or_id, run_name)
      existing = runs.find {|r| r.name == run_name}
      if existing
        return existing
      else
        return add_run(suite_name_or_id, :name => run_name)
      end
    end

    # Create a new Run in the given Suite in this project.
    def add_run(suite_name_or_id, fields={})
      run_data = fields.merge({
        :suite_id => suite_id(suite_name_or_id),
      })
      return add_entity(Run, data.id, run_data)
    end
  end
end # module RTrail

