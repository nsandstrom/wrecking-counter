class ReportsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	before_action :verify_passkey, only: [:set_owner, :set_boost]
	after_action :report_com, only: [:get_boost, :set_owner, :get_station_time_to_start]

	def index
		
	end


	def set_owner
		station = Station.find(params[:id])
		if Team.exists?(params[:owner]) && station.update(team_id: params[:owner])
		# if params[:owner].to_i.between?(1, Station.last.id)			
			render status: 202, text: "Ok"
		else
			head 400
		end
	end

	def get_owner
		if station = Station.find(params[:id])
			if station.team && (station.team_id.between? 1, 4)
				render status: 200, text: "Ok:#{station.team_id.to_s}"
				puts station.owner
			else
				render status: 200, text: "Ok:0"
			end
		end
	end

	def get_time
		head Time.now.to_i
	end

	def set_boost
		begin
			station = Station.find(params[:station])
		rescue
			render status: 404, text: "station not found\n" and return
		end
		if params[:boost].between?(50, 200) && station.update(boost: params[:boost])
			puts "#{station.boost} #{params["boost"]}"
			head 202
		else
			head 400
		end
	end

	def get_boost
		begin
			station = Station.find(params[:id])
		rescue
			render status: 404, text: "station not found\n" and return
		end
		render status: 200, text: "Ok:#{station.boost}"
	end

	def get_time_to_start
		if Round.active.count > 0
			render status: 200, text: "Ok:#{-(Round.active.first.seconds_left)}"
		elsif Round.coming.count > 0
			render status: 200, text: "Ok:#{((Round.coming.first.starttime - Time.now).to_i) +1}"
		else
			render status: 400, text: "Ok:999999"
		end
	end

	def get_station_time_to_start
		station = Station.find(params[:id])
		if Round.active.count > 0
			active_rounds = Round.active
			active_rounds.to_a.delete_if { |x| (1 << (station.id - 1)) & x.stations != (1 << (station.id - 1)) }

		end
		if active_rounds && active_rounds.size > 0
			render status: 200, text: "Ok:#{-(active_rounds.first.seconds_left)}" and return
		end


		if Round.coming.count > 0
			coming_rounds = Round.coming.to_a
			coming_rounds.delete_if { |x| (1 << (station.id - 1)) & x.stations != (1 << (station.id - 1)) }
		end
		if coming_rounds && coming_rounds.size > 0
			render status: 200, text: "Ok:#{((coming_rounds.first.starttime - Time.now).to_i) +1}" and return
		end
			render status: 200, text: "Ok:999999"
		
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

# curl -v -H "Content-Type: application/json" -X POST -d '{"station":1,"boost":100,"key":"hemligt"}' http://localhost:3000/reports/set_boost