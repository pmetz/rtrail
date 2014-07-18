require_relative 'spec_helper'

module RTrail
  describe Client do
    let(:base_url) { MOCK_APP_URL }
    let(:user) { "somebody" }
    let(:password) { "pa$$w0rd1" }
    let(:client) { Client.new(base_url, user, password) }

    describe "#initialize" do
      it "sets base_url, user, and password attributes" do
        expect(client.base_url).to eq(base_url)
        expect(client.user).to eq(user)
        expect(client.password).to eq(password)
      end
    end

    describe "#get" do
      it "sends a GET request" do
        expect(client).to receive(:_request).with(:get, 'get_project/1')
        client.get("get_project/1")
      end

      it "raises RTrail::Error when GET object is not found" do
        expect {
          client.get("get_project/999")
        }.to raise_error(RTrail::Error)
      end
    end

    describe "#post" do
      it "sends a POST request" do
        fields = {
          :suite_id => 1,
          :name => "Test Run",
        }
        expect(client).to receive(:_request).with(:post, 'add_run/1', fields)
        client.post("add_run/1", fields)
      end
    end
  end
end # module RTrail

