class Station < ActiveRecord::Base
  belongs_to :team


  def owner
  	self.team.name if self.team
  end

  def active  	
  	active_round = Round.active.last 
  	if active_round
  		(1 << (self.id - 1)) & active_round.stations == (1 << (self.id - 1))
  	else
  		false
  	end
  end
end
