require_relative 'entity'
require_relative 'methods'

module RTrail
  class Case < Entity
    include Helpers::HasCreateTime
    include Methods::Get
    include Methods::Update
    include Methods::Delete
  end
end # module RTrail

