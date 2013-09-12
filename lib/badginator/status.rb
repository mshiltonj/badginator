class Badginator
  class Status
    attr_reader :code, :awarded_badge

    def initialize(args = {})
      @code = args[:code]
    end

  end
end
