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
      let(:project1) { Project.new(1) }
      let(:project2) { Project.new(2) }

      describe "#initialize" do
        it "gets the project data" do
          expect(project1.id).to eq(1)
          expect(project1.name).to eq("First Project")
          expect(project2.id).to eq(2)
          expect(project2.name).to eq("Second Project")
        end
      end

      describe "#suite_by_name" do
        it "gets the Suite with the given name if it exists" do
          suite = project1.suite_by_name("First Suite")
          expect(suite).to be_a(Suite)
          expect(suite.name).to eq("First Suite")
        end

        it "raises RTrailError if no suite exists with the given name" do
          expect {
            project1.suite_by_name("Third Suite")
          }.to raise_error(RTrailError, /not found in project/)
          expect {
            project2.suite_by_name("First Suite")
          }.to raise_error(RTrailError, /not found in project/)
        end
      end

      describe "#suite" do
        it "returns a Suite by id" do
          suite = project1.suite(1)
          expect(suite).to be_a(Suite)
          expect(suite.id).to eq(1)
          expect(suite.name).to eq("First Suite")
        end

        it "returns a Suite by name" do
          suite = project1.suite("First Suite")
          expect(suite).to be_a(Suite)
          expect(suite.id).to eq(1)
          expect(suite.name).to eq("First Suite")
        end
      end

      describe "#suite_id" do
        it "returns the id for a Suite" do
          suite_id = project1.suite_id("First Suite")
          expect(suite_id).to eq(1)
        end
      end

      describe "#plans" do
        it "TODO"
      end

      describe "#runs" do
        it "returns all Runs in the Project" do
          runs = project1.runs
          expect(runs.count).to eq(2)
        end
      end

      describe "#suites" do
        it "returns all Suites in the project" do
          suites = project1.suites
          expect(suites.count).to eq(2)
        end
      end

      describe "#run" do
        it "TODO"
      end

      describe "#add_run" do
        it "TODO"
      end
    end

  end
end # module RTrail
