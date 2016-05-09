class Round < ActiveRecord::Base
	scope :active, -> { where active: true } 

	def remaining
		(Time.at(self.endtime - Time.zone.now).utc.strftime("%H:%M:%S")) if self.active
	end

	def pending
		Time.now = self.starttime
	end
end
