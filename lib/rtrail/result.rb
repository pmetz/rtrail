require_relative 'entity'
require_relative 'helpers'

module RTrail
  class Result < Entity
    include Helpers::HasCreateTime
  end
end # module RTrail

