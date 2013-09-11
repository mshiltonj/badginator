class Badginator
  module Nominee

    def self.included(base)
      base.class_eval {
        has_many :badges, class_name: "AwardedBadge"
      }
    end

    def try_award_badge(badge_name, context = {})
      badge = Badginator.get_badge(badge_name)

      badge.condition.call(self, context)
    end
  end
end
