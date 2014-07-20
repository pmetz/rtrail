require_relative 'entity'
require_relative 'methods'

module RTrail
  class Section < Entity
    include Methods::Get
    include Methods::Update
    include Methods::Delete
  end
end # module RTrail

