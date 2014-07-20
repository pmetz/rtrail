require_relative 'entity'
require_relative 'methods'

module RTrail
  class Plan < Entity
    include Methods::Get
    include Methods::Update
    include Methods::Close
    include Methods::Delete
  end
end # module RTrail

