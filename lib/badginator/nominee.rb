class Badginator
  module Nominee
    def try_award_badge(badge_name, context = {})
      badge = Badginator.get_badge(badge_name)

      badge.condition.call(self, context)
    end
  end
end
