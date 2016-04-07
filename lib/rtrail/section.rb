require_relative 'entity'
require_relative 'case'
require_relative 'suite'
require_relative 'methods'

module RTrail
  class Section < Entity
    include Methods::Get
    include Methods::Update
    include Methods::Delete

    # Return the Suite this Section is in
    def suite
      return Suite.get(data.suite_id)
    end

    # Return the Cases in this Section
    def cases
      return suite.cases(data.id)
    end

    # Add a new Case to the Section
    # Requires :title, :custom_steps_separated, :custom_expected
    # :custom_steps_separated => [ {'content' => 'Action', 'expected' => 'Expectation'}, ... ]
    def add_case(fields={})
      return add_entity(Case, data.id, fields)
    end

    # Add a Section within this Section
    def add_subsection(fields={})
      _suite = suite
      subsection_data = fields.merge({
        :suite_id => _suite.id,
        :parent_id => data.id
      })
      return add_entity(Section, _suite.project_id, subsection_data)
    end

    # Return all Subsections in this Section
    def subsections
      return suite.sections.select do |sect|
        sect.parent_id == data.id
      end
    end
  end # class Section
end # module RTrail

