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

    def section_by_name(section_name)
      section = sections.find do |s|
        s.name == section_name
      end
      if section.nil?
        raise RTrail::NotFound.new(
          "Section '#{section_name}' not found in Suite '#{self.data.name}'")
      end
    end

    def section(section_name_or_id)
      if is_id?(section_name_or_id)
        return Section.get(section_name_or_id)
      else
        return section_by_name(section_name_or_id)
      end
    end
  end

end # module RTrail

