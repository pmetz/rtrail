require_relative 'spec_helper'
require 'rtrail/helpers'
require 'hashie'

module RTrail
  describe Helpers do
    class Thing < Hashie::Mash
      include RTrail::Helpers
    end

    let(:thing) { Thing.new }

    describe "#is_id?" do
      it "returns true for numeric strings" do
        expect(thing.is_id?('0')).to be true
        expect(thing.is_id?('4')).to be true
        expect(thing.is_id?('117')).to be true
        expect(thing.is_id?('62521')).to be true
      end

      it "returns false for non-numeric strings" do
        expect(thing.is_id?('')).to be false
        expect(thing.is_id?('x')).to be false
        expect(thing.is_id?('Foobar')).to be false
        expect(thing.is_id?('This sentence no verb')).to be false
      end
    end

    describe "#path_with_params" do
      it "appends params to the path using TestRail's GET syntax" do
        result = thing.path_with_params("/add_run/1", :suite_id => 4)
        expect(result).to eq("/add_run/1&suite_id=4")
      end
    end

    describe Helpers::HasCreateTime do
      class Thing < Hashie::Mash
        include RTrail::Helpers::HasCreateTime
      end

      let(:now) { Time.utc(2014, 'may', 19, 3, 45, 0) }
      let(:thing) { Thing.new(:created_on => now.to_i) }

      describe "#create_time" do
        it "returns the `created_on` attribute as a Time" do
          expect(thing.create_time).to be_a(Time)
          expect(thing.create_time).to eq(now)
        end
      end
    end
  end
end # module RTrail

