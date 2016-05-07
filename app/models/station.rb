class Station < ActiveRecord::Base
  belongs_to :team


  def owner
  	self.team.name if self.team
  end
end
