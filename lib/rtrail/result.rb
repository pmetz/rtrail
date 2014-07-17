require_relative 'entity'

module RTrail
  class Result < Entity
    def create_time
      return Time.at(self[:created_on].to_i).utc
    end
  end
end # module RTrail

