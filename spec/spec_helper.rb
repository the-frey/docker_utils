$:.unshift File.expand_path(File.dirname(__FILE__))

require 'rspec'
require 'yaml'
require_relative '../lib/exceptions'
require_relative '../lib/deploy'

RSpec.configure do |config|
  config.order = 'random'
end