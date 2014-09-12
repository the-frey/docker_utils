require 'spec_helper'

describe "Deploy module" do

  let(:test_yaml) { YAML.load(File.open(File.dirname(__FILE__) + '/test.yml')) }

  describe "Container" do
    pending
  end

  describe "if YAML" do

    it "is valid" do
      expect(test_yaml["memcached"]["name"]).to eq 'memcached-docker'
    end

  end

  describe "if YAML is invalid" do

    let(:test_yaml) { nil }

    it "test should be nil" do
      expect(test_yaml).to eq nil
    end

    it "should log an error and exit" do
      expect { Deploy::Container.new('grandmaster_yk_kim', 'http://www.example.com', test_yaml) }.to raise_error(Exceptions::NoContainersError)
    end
  end
  
end