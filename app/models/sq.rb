class Sq < ActiveRecord::Base
	def sq_condition
		case self.sq.to_i
		when 2..9
			"Marginal"
		when 10..14
			"OK"
		when 15..19
			"Good"
		when 20..30
			"Excellent"
		else
			"unknown"
		end
	end
end
