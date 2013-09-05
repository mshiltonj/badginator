require 'singleton'
require "badginator/version"
require "badginator/badge"
require "badginator/nominee"

class Badginator
  include Singleton

  def initialize
    @badges = {}
  end

  def get_badge(badge_code)
    @badges.fetch(badge_code)
  end

  def define_badge(*args, &block)
    badge = Badge.new
    badge.build_badge &block

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
end
