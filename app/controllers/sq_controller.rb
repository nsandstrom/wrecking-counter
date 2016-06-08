class SqController < ApplicationController
	def create
		Sq.create(name: "name_me", time: Time.now, sq: params[:sq])
		head 202
	end

	def index
		@sq_reports = Sq.all
	end
end


#report sq 99 :  	root/sq/99
#list: 				root/sqs
#show report 1:		root/sqs/1