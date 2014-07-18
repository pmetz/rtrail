require_relative 'spec_helper'

module RTrail
  describe Test do
    context "Class methods" do
    end

    context "Instance methods" do
      let(:test) { Test.new(1) }

      describe "#results" do
        let(:results) { test.results }
        it "returns all Results for the Test" do
          expect(results).to be_an(Array)
          expect(results.first).to be_a(Result)
        end
      end

      describe "#latest_result" do
        let(:latest_result) { test.latest_result }
        it "returns the most recent Result for the Test" do
          expect(latest_result).to be_a(Result)
        end
      end

      describe "#add_result" do
        it "returns a new Result" do
          test.add_result(:status_id => 1)
        end
      end
    end
  end
end # module RTrail

