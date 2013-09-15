class Badginator
  module Nominee

    def self.included(base)
      base.class_eval {
        has_many :badges, class_name: "AwardedBadge", as: :awardee
      }
    end

    def try_award_badge(badge_name, context = {})
      badge = Badginator.get_badge(badge_name)

      success =  badge.condition.call(self, context)

      if success
        if (self.has_badge?(badge_name))
          status = Badginator::Status(Badginator::ALREADY_WON)
        else
          awarded_badge = AwardedBadge.create! awardee: self, badge_code: badge.code
          status = Badginator::Status(Badginator::WON, awarded_badge)
        end
      else
        status = Badginator::Status(Badginator::DID_NOT_WIN)
      end

      status
    end

    def has_badge?(badge_code)
      AwardedBadge.where(badge_code: badge_code, awardee: self).first
    end
  end
end
