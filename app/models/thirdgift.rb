class Thirdgift < ActiveRecord::Base
	def self.get_action action_path
		request_options = {method: :get, path: action_path}
		response = call_api(request_options)
	end

	def self.set_station_owner station, owner
		station = station.to_i
		owner = owner.to_i
		owner = -1 if owner == 0
		request_options = {method: :post, path: "/lanternStations/#{station}"}
		request_options[:params] = {"data" => {"station" => {"owner" => owner}}}
		response = call_api_background(request_options)
	end

	def self.under_capture station
		station = station.to_i
		request_options = {method: :post, path: "/lanternStations/#{station}"}
		request_options[:params] = {"data" => {"station" => {"isUnderAttack" => true}}}
		call_api_background(request_options)
	end

	def self.create_round id, start_time, end_time
	end

	def self.update_round_time
		if Round.active.count > 0
			round = Round.active.first
			active = true
		elsif Round.coming.count > 0
			round = Round.coming.first
			active = false
		else
			active = false
		end

		if round
			start_time = round.starttime.to_s
			end_time = round.endtime.to_s
		else
			start_time = ""
			end_time = nil
		end
		request_options = {method: :post, path: "/lanternRounds/time"}
		request_options[:params] = {"data" => {"startTime" => start_time, "endTime" => end_time, "isActive" => active}}
		call_api_background(request_options)
	end

	def self.update_team_score team
		request_options = {method: :post, path: "/lanternTeams/#{team.id}"}
		request_options[:params] = {"data" => {"team" => {"points" => team.score }}}
		call_api_background(request_options)
	end

	def self.set_active_stations
		Station.all.each do |station|
			isActive = station.active
			request_options = {method: :post, path: "/lanternStations/#{station.id}"}
			request_options[:params] = {"data" => {"station" => {"isActive" => isActive}}}
			call_api_background(request_options)
		end

	end

	# def self.update_station station
	# 	station_is_existing = get_station station.id
	# 	if station_is_existing == true
	# 		puts "update"
	# 		modify_station station
	# 	elsif station_is_existing == false
	# 		puts "create new"
	# 	else
	# 		return nil
	# 	end
	# end

	# def self.update_team team
	# 	team_is_existing = get_team team.id
	# 	if team_is_existing == true
	# 		puts "update"
	# 		modify_team team
	# 	elsif team_is_existing == false
	# 		puts "create new"
	# 	else
	# 		return nil
	# 	end
	# end

	def self.update_station station
		station.team_id = -1 if station.team_id == nil
		begin
			result = modify_station station
			raise error unless result["data"]["station"]["stationId"].to_i == station.id.to_i
			return true
		rescue
			begin
				create_station station
				raise error unless result["data"]["station"]["stationId"].to_i == station.id.to_i
				return true
			rescue
				return false
			end
		end
	end

	def self.update_team team
		begin
			result = modify_team team
			raise error unless result["data"]["team"]["teamId"].to_i == team.id.to_i
			return true
		rescue
			begin
				create_team team
				raise error unless result["data"]["team"]["teamId"].to_i == team.id.to_i
				return true
			rescue
				return false
			end
		end
	end

	def self.create_station station
		request_options = {method: :post, path: "/lanternStations"}
		request_options[:params] = {"data" => {"station" => {"stationId" => station.id.to_i, "stationName" => station.location }}}
		response = call_api(request_options)
	end

	def self.modify_station station
		request_options = {method: :post, path: "/lanternStations/#{station.id}"}
		request_options[:params] = {"data" => {"station" => {"stationName" => station.location, "owner" => station.team_id,	"calibrationReward" => station.reward	}}}
		response = call_api(request_options)
	end

	def self.create_team team
		request_options = {method: :post, path: "/lanternTeams"}
		request_options[:params] = {"data" => {"team" => {"teamId" => team.id, "shortName" => team.short_name, "teamName" => team.name, "points" => team.score }}}
		response = call_api(request_options)
	end

	def self.modify_team team
		request_options = {method: :post, path: "/lanternTeams/#{team.id}"}
		request_options[:params] = {"data" => {"team" => {"shortName" => team.short_name, "teamName" => team.name, "points" => team.score }}}
		response = call_api(request_options)
	end

	def self.submit_calibration_code code
		request_options = {method: :post, path: "/users/#{code.owner}/calibrationMission/complete"}
		begin
			response = call_api(request_options)
			raise error unless response["data"]["mission"]["code"].to_i == code.code.to_i
			return true
		rescue
			return false
		end
	end



	private
	def self.call_api options = {}
		return make_request options
	end

	def self.call_api_background options = {}
		Thread.new do
			make_request options
		end
		return nil
	end

	def self.make_request options = {}
		puts "wait for external API-call"
		# sleep 5
		puts "Call to #{options[:path]}"
		req_method = options[:method] || :get
		payload = options[:params] || {}
		puts "payload: #{payload}"
		begin
			response = RestClient::Request.execute(
				method: req_method,
				url: "https://devbbrterminal.thethirdgift.com/api#{options[:path]}",
				headers: {Authorization: ENV['thirdgift_api_token'], :content_type => 'application/json'},
				payload: payload.to_json,
				timeout: 10
			)
			puts response	
			return JSON.parse response
		rescue RestClient::ExceptionWithResponse => e
			puts e.response
			begin
				return JSON.parse e.response
			rescue
				return {}
			end
		end
	end

	def self.get_station station_id
		request_options = {method: :get, path: "/lanternStations/#{station_id}"}
		response = call_api request_options
		if response.dig("data", "station", "stationId") == station_id.to_i
			return true
		elsif response.dig("error", "status") == 404
			return false
		else
			return nil
		end
		
	end

	# def self.get_team team_id
	# 	request_options = {method: :get, path: "/lanternTeams/#{team_id}"}
	# 	response = call_api request_options
	# 	if response.dig("data", "station", "teamId") == team.to_i
	# 		return true
	# 	elsif response.dig("error", "status") == 404
	# 		return false
	# 	else
	# 		return nil
	# 	end
		
	# end
end
