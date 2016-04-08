require_relative 'entity'
require_relative 'case'
require_relative 'suite'
require_relative 'methods'

module RTrail
  class Section < Entity
    include Methods::Get
    include Methods::Update
    include Methods::Delete

    # Return the Suite this Section is in
    def suite
      return Suite.get(data.suite_id)
    end

    # Return the Cases in this Section
    def cases
      return suite.cases(data.id)
    end

    def case_by_title(case_title)
      kase = cases.find do |c|
        c.title == case_title
      end
      if kase.nil?
        raise RTrail::NotFound.new(
          "Case '#{case_title}' not found in Section '#{data.name}'")
      end
      return kase
    end

    # Return the Case matching a title or ID
    def case(case_title_or_id)
      if is_id?(case_title_or_id)
        return Case.get(case_title_or_id)
      else
        return case_by_title(case_title_or_id)
      end
    end

    # Add a new Case to the Section
    # Requires :title, :custom_steps_separated, :custom_expected
    # :custom_steps_separated => [ {'content' => 'Action', 'expected' => 'Expectation'}, ... ]
    def add_case(fields={})
      return add_entity(Case, data.id, fields)
    end

    # Add a Section within this Section
    def add_subsection(fields={})
      _suite = suite
      subsection_data = fields.merge({
        :suite_id => _suite.id,
        :parent_id => data.id
      })
      return add_entity(Section, _suite.project_id, subsection_data)
    end

    # Return all Subsections in this Section
    def subsections
      return suite.sections.select do |sect|
        sect.parent_id == data.id
      end
    end

    # Return the subsection with the given name
    def subsection_by_name(subsection_name)
      subsect = subsections.find do |s|
        s.name == subsection_name
      end
      if subsect.nil?
        raise RTrail::NotFound.new(
          "Sub-Section '#{subsection_name}' not found within Section '#{data.name}'")
      end
      return subsect
    end

    # Return the Subsection with the given name or ID
    def subsection(subsection_name_or_id)
      if is_id?(subsection_name_or_id)
        return Section.get(subsection_name_or_id)
      else
        return subsection_by_name(subsection_name_or_id)
      end
    end
  end # class Section
end # module RTrail

