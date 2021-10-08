require 'spec_helper'

describe NftmakerApi do
  subject { described_class.new }

  describe "configuration" do
    it "has default settings" do
      expect(subject.configuration.api_key).to eq nil
      expect(subject.configuration.host).to eq "https://api.nft-maker.io"
      expect(subject.configuration.http_adapter).to eq :net_http
    end

    it "allows to change settings" do
      described_class.configure do |c|
        c.api_key = "12345678"
        c.host = "foobar.com"
        c.http_adapter = :typhoeus
      end

      expect(subject.configuration.api_key).to eq "12345678"
      expect(subject.configuration.host).to eq "foobar.com"
      expect(subject.configuration.http_adapter).to eq :typhoeus
      expect(subject.http_client.adapter).to eq Faraday::Adapter::Typhoeus
    end

    it "allows settings per instance" do
      client_1 = described_class.new(host: "foo.com", api_key: "foo123")
      expect(client_1.api_key).to eq "foo123"
      expect(client_1.host).to eq "foo.com"

      client_2 = described_class.new(host: "bar.com", api_key: "bar123")
      expect(client_2.api_key).to eq "bar123"
      expect(client_2.host).to eq "bar.com"
    end
  end
end
