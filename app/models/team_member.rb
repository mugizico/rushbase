class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_team
end
