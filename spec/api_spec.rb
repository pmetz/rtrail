require_relative 'spec_helper'
require 'rtrail/api'

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
  end
end # module RTrail

