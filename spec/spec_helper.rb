require_relative "../lib/badginator"
require_relative "../spec/models/test_nominee"

def reset_badginator
  Singleton.send :__init__, Badginator
end
