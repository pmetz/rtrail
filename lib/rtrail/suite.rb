require_relative 'entity'
require_relative 'case'
require_relative 'section'
require_relative 'methods'

module RTrail
  class Suite < Entity
    include Methods::Get
    include Methods::Update
    include Methods::Delete

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

