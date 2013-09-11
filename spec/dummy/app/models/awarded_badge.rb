class AwardedBadge < ActiveRecord::Base
  belongs_to :awardee, polymorphic: true

end
