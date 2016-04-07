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
  end # class Section
end # module RTrail

