require_relative 'spec_helper'

module RTrail
  describe Suite do
    context "Class methods" do
    end

    context "Instance methods" do
      let(:suite) { Suite.get(1) }

      describe "#sections" do
        let(:sections) { suite.sections }
        it "returns all Sections in the Suite" do
          expect(sections).to be_an(Array)
          expect(sections.first).to be_a(Section)
        end
      end

      describe "#cases" do
        let(:cases) { suite.cases }
        it "returns all Cases in the Suite" do
          expect(cases).to be_an(Array)
          expect(cases.first).to be_a(Case)
        end
      end

      describe "#section_by_name" do
        it "gets the Section with the given name if it exists"
        it "raises RTrail::NotFound if no section exists with the given name"
      end

      describe "#section" do
        it "returns a Section by id"
        it "returns a Section by name"
      end
    end
  end
end # module RTrail

