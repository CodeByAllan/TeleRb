# frozen_string_literal: true

require "./lib/telerb/http_client"

RSpec.describe HttpClient do
  let(:client) { HttpClient.new }
  describe "#get" do
    it "http get " do
      url = "exemple.com"
      allow(client).to receive(:get).with(url).and_return("Hello World!")
      expect(client.get(url)).to eq("Hello World!")
    end
  end
  describe "#post" do
    it "http post " do
      url = "exemple.com"
      body = { name: "ruby" }
      allow(client).to receive(:post).with(url, body).and_return("Sucess!")
      expect(client.post(url, body)).to eq("Sucess!")
    end
  end
end
