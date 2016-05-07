class ReportsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	before_action :verify_passkey, only: :set_owner

	def index
		
	end


	def set_owner
		station = Station.find(params[:id])
		if Team.exists?(params[:owner]) && station.update(team_id: params[:owner])
		# if params[:owner].to_i.between?(1, Station.last.id)			
			head 202
		else
			head 400
		end
	end

	def get_time
		head Time.now.to_i
	end

	private
		def verify_passkey
			if params[:key] == ENV['submit_password']
				puts "lösen #{params[:key]} är ok"
				true
			else
				puts "lösen #{params[:key]} är fel"
				head 401
			end
		end
end


# curl -X PUT -H "Content-Type: multipart/form-data;" -F "1=2" "localhost:3000/reports/2/owner?key=hemligt;owner=2" -v