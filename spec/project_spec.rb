require_relative 'spec_helper'
require 'rtrail/project'

module RTrail
  describe Project do
    context "Class methods" do
      describe "#all" do
        it "returns all Projects" do
          projects = Project.all
          expect(projects).to be_an(Array)
        end
      end

      describe "#by_name" do
        it "returns the Project with the given name if it exists" do
          project = Project.by_name("First Project")
          expect(project).to be_a(Project)
          expect(project).to_not be_nil
          expect(project.name).to eq("First Project")
        end

        it "raises RTrailError if no project exists with the given name" do
          expect {
            Project.by_name("Bogus Project Name")
          }.to raise_error(RTrailError, /not found in TestRail/)
        end
      end
    end

    context "Instance methods" do
      describe "#initialize" do
        it "gets the project data" do
          project = Project.new(1)
          expect(project).to_not be_nil
          expect(project.id).to eq(1)
        end
      end
    end

  end
end # module RTrail

