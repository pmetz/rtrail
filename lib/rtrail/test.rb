require_relative 'entity'
require_relative 'result'
require_relative 'methods'

module RTrail
  class Test < Entity
    include Methods::Get

    # Return all Results for this Test.
    def results
      return get_entities(Result, data.id)
    end

    # Return the most recently created Result for this Test.
    def latest_result
      return get_entities(Result, data.id, :limit => 1).first
    end

    # Add a new Result to this test.
    def add_result(fields)
      return add_entity(Result, data.id, fields)
    end
  end
end # module RTrail

