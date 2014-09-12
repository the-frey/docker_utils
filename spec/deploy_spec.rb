require 'spec_helper'

describe "Deploy module" do

  let(:test_yaml) { YAML.load(File.open(File.dirname(__FILE__) + '/test.yml')) }

  describe "Container" do

    describe "if YAML is valid" do

      before do 
        @container = Deploy::Container.new('grandmaster_yk_kim', 'http://www.example.com', test_yaml[1])
      end

      it "YAML should have accessible keys" do
        expect(test_yaml[1]["name"]).to eq 'memcached-docker'
      end

      describe "the container should have accessible attributes" do
        subject { @container }

        it { should respond_to(:user) }
        it { should respond_to(:host) }
        it { should respond_to(:name) }
        it { should respond_to(:repo) }
        it { should respond_to(:tag) }
        it { should respond_to(:flags) }

      end

      it "should set accessible attributes on container object" do

        expect(@container.user).to eq "grandmaster_yk_kim"      
        expect(@container.host).to eq "http://www.example.com"      
        expect(@container.name).to eq "memcached-docker"      
        expect(@container.repo).to eq "widgetcorp/memcached"      
        expect(@container.tag).to eq "1.2.3"    
        expect(@container.flags).to eq ["-v /var/lib/memcacheddata:/data", "-e FOO='BAR'"]      

      end

      it "#run_command should return the correct output" do
        expect(@container.run_command).to eq "docker run -d --name memcached-docker -v /var/lib/memcacheddata:/data -e FOO='BAR' widgetcorp/memcached:1.2.3"
      end

    end

    describe "if repo is empty" do

      before do
        @new_yaml = test_yaml
        @new_yaml[1]["repo"] = ''
      end

      it "should not be nil" do
        expect(test_yaml).not_to eq nil
      end

      it "should log an error and exit" do
        expect { Deploy::Container.new('grandmaster_yk_kim', 'http://www.example.com', @new_yaml) }.to raise_error(Exceptions::NoRepoError)
      end
    end

    describe "if repo is nil" do

      before do
        @new_yaml = test_yaml
        @new_yaml[1]["repo"] = nil
      end

      it "should not be nil" do
        expect(test_yaml).not_to eq nil
      end

      it "should log an error and exit" do
        expect { Deploy::Container.new('grandmaster_yk_kim', 'http://www.example.com', @new_yaml) }.to raise_error(Exceptions::NoRepoError)
      end
    end

    describe "if repo key is missing" do

      before do
        @new_yaml = test_yaml
        @new_yaml[1].delete("repo")
      end

      it "should not be nil" do
        expect(test_yaml).not_to eq nil
      end

      it "should not have repo key" do
        expect(@new_yaml[1].has_key?("repo")).to eq false
      end

      it "should log an error and exit" do
        expect { Deploy::Container.new('grandmaster_yk_kim', 'http://www.example.com', @new_yaml) }.to raise_error(Exceptions::NoRepoError)
      end
    end

    describe "if YAML is nil" do

      let(:test_yaml) { nil }

      it "test should be nil" do
        expect(test_yaml).to eq nil
      end

      it "should log an error and exit" do
        expect { Deploy::Container.new('grandmaster_yk_kim', 'http://www.example.com', test_yaml) }.to raise_error(Exceptions::NoContainerError)
      end
    end

  end
  
end