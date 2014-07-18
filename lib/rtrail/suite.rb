require_relative 'entity'
require_relative 'case'
require_relative 'section'

module RTrail
  class Suite < Entity
    def sections
      return get_entities(
        Section,
        data.project_id,
        :suite_id => data.id
      )
    end

    def cases(section_id=nil)
      return get_entities(
        Case,
        data.project_id,
        :suite_id => data.id,
        :section_id => section_id
      )
    end
  end

end # module RTrail

