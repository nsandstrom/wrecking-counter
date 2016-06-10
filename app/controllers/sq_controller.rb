class SqController < ApplicationController
	def create
		if Sq.create(name: "name_me", time: Time.now, sq: params[:sq])
			head 202
		end
	end

	def index
		@sqs = Sq.all
	end

	def show
		@sq = Sq.find(params[:id])
	end

	def edit
		@sq = Sq.find(params[:id])
  	end

  	def update
  		@sq = Sq.find(params[:id])
  		@sq.update(sq_params)
  		redirect_to sqs_path
  	end

	def destroy
		@sq = Sq.find(params[:id])
	    @sq.destroy
	    redirect_to sqs_path
	end

	private
	def sq_params
      params.require(:sq).permit(:name)
    end
end


#report sq 99 :  	root/sq/99
#list: 				root/sqs
#show report 1:		root/sqs/1