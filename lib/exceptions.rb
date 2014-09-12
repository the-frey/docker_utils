module Exceptions
  class NoContainersError < StandardError
    def initialize(msg = "No containers specified, or YAML evaluated to nil.")
      super
    end
  end
end