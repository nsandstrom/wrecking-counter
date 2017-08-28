class ThirdgiftController < ApplicationController
	def index
		begin
			@teams = Thirdgift.get_action("/lanternTeams")["data"]["teams"]
		rescue
			@teams = {}
		end

		begin
			@active_stations = Thirdgift.get_action("/lanternStations")["data"]["activeStations"]
			@inactive_stations = Thirdgift.get_action("/lanternStations")["data"]["inactiveStations"]
		rescue
			@active_stations = {}
			@inactive_stations = {}
		end

		begin
			@round_stats = Thirdgift.get_action("/lanternRounds")["data"]
			puts @round_stats.inspect
		rescue
			@round_stats = {}
		end

		begin
			@calibration_codes = Thirdgift.get_action("/calibrationMissions/active")["data"]["missions"]
		rescue
			@calibration_codes = {}
		end

	end

	def user
		users = Thirdgift.get_action("/users")["data"]["users"]
		begin
			@user = users.select {|user| user["userName"] == params[:name]}.first
			raise Error unless @user
		rescue
			head 404
		end
	end

	def users
		@users = Thirdgift.get_action("/users")["data"]["users"]
	end
end
