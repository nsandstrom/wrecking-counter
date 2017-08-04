class CalibrationCode < ActiveRecord::Base
	validates_presence_of :owner, :code, :station_id

	def self.disable_old owner
		CalibrationCode.where(owner: owner).update_all(completed: true)
	end
end
