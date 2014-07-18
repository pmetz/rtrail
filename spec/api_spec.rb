require_relative 'spec_helper'

module RTrail
  describe API do
    let(:api) { API.new("http://localhost:8080/", "user", "password") }

    describe "#initialize" do
      it "initializes the client" do
        expect(api.client).to_not be_nil
      end
    end

    describe "#project" do
      it "returns a Project instance" do
        project = api.project("First Project")
        expect(project).to be_a(Project)
        expect(project.name).to eq("First Project")
      end
    end

    describe "#runs" do
      it "returns all Runs for the given Project" do
        runs = api.runs("First Project")
        expect(runs).to be_an(Array)
        expect(runs.first).to be_a(Run)
      end
    end

    describe "#cases" do
      it "returns all Cases for the given Project and Suite" do
        cases = api.cases("First Project", "First Suite")
        expect(cases).to be_an(Array)
        expect(cases.first).to be_a(Case)
      end
    end
  end
end # module RTrail

