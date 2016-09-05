class PublicController < ApplicationController
	def index
		@stations = Station.all
		@teams = Team.all
		@active_round = Round.active.order('endtime desc').first
		@coming_rounds = Round.coming.order('starttime')
	end
end
