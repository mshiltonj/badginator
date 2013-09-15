class AwardedBadge < ActiveRecord::Base
  belongs_to :awardee, polymorphic: true

  def badge
    Badginator.get_badge(badge_code.to_sym)
  end

end
