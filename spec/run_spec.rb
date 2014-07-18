require_relative 'spec_helper'
require 'rtrail/run'

module RTrail
  describe Run do
    context "Class methods" do
    end

    context "Instance methods" do
      let(:run1) { Run.new(1) }
      let(:run2) { Run.new(2) }

      describe "#initialize" do
        it "gets the Run data" do
          expect(run1.id).to eq(1)
          expect(run2.id).to eq(2)
        end
      end

      describe "#summary" do
        it "includes id and name" do
          expect(run1.summary).to include(run1.id.to_s)
          expect(run1.summary).to include(run1.name)
        end

        it "includes completion status" do
          expect(run1.summary).to include("[completed")
          expect(run2.summary).to include("[not completed")
        end
      end

      describe "#tests" do
        it "includes all Tests in the Run" do
          expect(run1.tests).to be_an(Array)
          expect(run1.tests.first).to be_a(Test)
        end
      end

      describe "#complete_time" do
        it "returns a Time if `completed_on` is set" do
          expect(run1.complete_time).to be_a(Time)
        end

        it "returns nil if `completed_on` is nil" do
          expect(run2.complete_time).to be_nil
        end
      end

      describe "#completed?" do
        it "returns true if `completed_on` is set" do
          expect(run1.completed?).to be true
        end

        it "returns false if `completed_on` is nil" do
          expect(run2.completed?).to be false
        end
      end

    end
  end
end # module RTrail

