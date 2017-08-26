class Team < ActiveRecord::Base
	has_many :stations
	serialize :captured_stations, JSON

	def self.clear_captured_stations
		self.all.update_all(captured_stations: [])
	end

	def check_capture_bonus station
		if self.captured_stations.include? station
		else
			self.captured_stations << station
			self.score += 10000
		end


		self.save
	end
end
