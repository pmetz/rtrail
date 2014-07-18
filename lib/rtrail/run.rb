require_relative 'entity'
require_relative 'test'
require_relative 'helpers'

module RTrail
  class Run < Entity
    include HasCreateTime

    # Return a one-line summary of this Run
    def summary
      # TODO: Include these?
      # self.untested_count
      # self.blocked_count
      # self.passed_count
      # self.failed_count
      result = "#{self.id}: #{self.name}"
      if self.completed?
        result += " [completed #{self.complete_time}]"
      else
        result += " [not completed]"
      end
      return result
    end

    def tests
      return get_entities(Test, data.id)
    end

    def complete_time
      return nil if !completed?
      return Time.at(self[:completed_on].to_i).utc
    end

    def completed?
      return !self[:completed_on].nil?
    end
  end
end # module RTrail

