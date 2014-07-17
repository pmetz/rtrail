require_relative 'entity'
require_relative 'case'

module RTrail
  class Suite < Entity
    def sections
      return get_entities(Section, data.id)
    end

    def cases(section_id=nil)
      params = {
        :suite_id => data.id,
        :section_id => section_id
      }
      return get_entities(Case, data.project_id, params)
    end
  end

end # module RTrail

