require 'singleton'
require "badginator/version"
require "badginator/badge"
require "badginator/status"
require "badginator/nominee"

class Badginator
  include Singleton

  DID_NOT_WIN = 1
  WON         = 2
  ALREADY_WON = 3
  ERROR       = 4

  def initialize
    @badges = {}
  end

  def get_badge(badge_code)
    @badges.fetch(badge_code)
  end

  def badges
    @badges.values.select { |badge| ! badge.disabled }
   end

  def self.badges
    self.instance.badges
  end

  def define_badge(*args, &block)
    badge = Badge.new
    badge.build_badge &block
    badge.freeze

    if @badges.key?(badge.code)
      raise "badge code '#{badge.code}' already defined."
    end

    @badges[badge.code] = badge
  end

  def self.define_badge(*args, &block)
    self.instance.define_badge(*args, &block)
  end

  def self.get_badge(badge_code)
    self.instance.get_badge(badge_code)
  end

  def self.Status(status_code, badge = nil)
    case status_code
      when DID_NOT_WIN, WON, ALREADY_WON, ERROR
        Badginator::Status.new code: status_code, badge: badge
      else
        rails TypeError, "Cannot convert #{status_code} to Status"
    end
  end
end
