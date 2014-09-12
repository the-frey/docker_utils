module Exceptions
  class NoContainerError < StandardError
    def initialize(msg = "No containers specified, or YAML evaluated to nil.")
      super
    end
  end

  class NoRepoError < StandardError
    def initialize(msg = "No repository or image specified in YAML.")
      super
    end
  end
end