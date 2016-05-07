class UsersController < ApplicationController
	before_action :authenticate_user

	def index
		@users = User.all
	end
	
	def new
		@user = User.new unless @user
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to index_path
		else
			redirect_to :back
		end
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password)
		end
end
