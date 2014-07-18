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
    end
  end
end # module RTrail

