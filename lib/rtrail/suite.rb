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

    def cases(section_name_or_id=nil)
      if section_name_or_id
        section_id = section(section_name_or_id).id
      else
        section_id = nil
      end
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
      if section
        return section
      else
        raise RTrail::NotFound.new(
          "Section '#{section_name}' not found in Suite '#{data.name}'")
      end
    end

    def section(section_name_or_id)
      if is_id?(section_name_or_id)
        return Section.get(section_name_or_id)
      else
        return section_by_name(section_name_or_id)
      end
    end

    # Add a Section to the Suite.
    # Requires :name
    def add_section(fields={})
      section_data = fields.merge({
        :suite_id => data.id,
      })
      return add_entity(Section, data.project_id, section_data)
    end
  end

end # module RTrail

