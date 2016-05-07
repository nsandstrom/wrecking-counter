class SessionsController < ApplicationController
	def new
		redirect_to '/' unless session[:user_id] == nil
	end

	def create
	  @user = User.find_by_email(params[:session][:email])
	  if @user && @user.authenticate(params[:session][:password])
	    session[:user_id] = @user.id
	    redirect_to '/'
	  else
	    redirect_to login_path
	  end 
	end


	def destroy 
	  session[:user_id] = nil 
	  redirect_to '/' 
	end
end
