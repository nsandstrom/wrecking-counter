class PublicController < ApplicationController
	def index
		@stations = Station.all
		@teams = Team.all
		@round = Round.active.order('endtime desc').first
	end
end
