class Thirdgift < ActiveRecord::Base
	def self.set_station_owner station, owner
		station = station.to_i
		owner = owner.to_i
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
			start_time = nil
			end_time = nil
		end
		request_options = {method: :post, path: "/lanternRounds/time"}
		request_options[:params] = {"data" => {"startTime" => start_time, "endTime" => end_time, "isActive" => active}}
		call_api_background(request_options)
	end

	def self.update_station station
		station_is_existing = get_station station.id
		if station_is_existing == true
			puts "update"
			modify_station station
		elsif station_is_existing == false
			puts "create new"
		else
			return nil
		end
	end

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

	def self.create_station station
		request_options = {method: :post, path: "/lanternStations"}
		request_options[:params] = {"data" => {"station" => {"stationId" => station.id.to_i, "stationName" => station.location }}}
		response = call_api(request_options)
	end

	def self.modify_station station
		request_options = {method: :post, path: "/lanternStations/#{station.id}"}
		request_options[:params] = {"data" => {"station" => {"stationId" => station.id.to_i, "stationName" => station.location, "owner" => station.team_id	}}}
		response = call_api(request_options)
	end

	# def self.create_team team
	# 	request_options = {method: :post, path: "/lanternTeams"}
	# 	request_options[:params] = {"data" => {"team" => {"teamId" => team.id, "shortName" => team.short_name, "teamName" => team.name }}}
	# 	response = call_api(request_options)
	# end



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
		sleep 5
		puts "Call to #{options[:path]}"
		req_method = options[:method] || :get
		payload = options[:params] || {}
		puts "payload: #{payload}"
		begin
			response = RestClient::Request.execute(
				method: req_method,
				url: "https://devbbrterminal.thethirdgift.com/api#{options[:path]}",
				headers: {Authorization: ENV['thirdgift_api_token'], :content_type => 'application/json'},
				payload: payload.to_json
			)
			puts response	
			return JSON.parse response
		rescue RestClient::ExceptionWithResponse => e
	    	puts e.response
	    	return JSON.parse e.response
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
	# 	request_options = {method: :get, path: "/lanternTeams/#{team}"}
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