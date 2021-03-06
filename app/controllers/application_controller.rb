class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def reset

  	teams = Team.all 
  	teams.each do |team|
  		team.update(score: 0)
  	end

  	Station.all.each do |station|
  		station.update(team_id: nil, boost: 100)
  	end

  	redirect_to '/'
  end
  
  def authenticate_user
    unless session[:user_id] ==  "" || session[:user_id] ==  nil 
      @current_user = User.find(session[:user_id])
    end
    puts "format- #{request.format}"
    redirect_to login_path, notice: "You're not logged in" unless @current_user || request.format == "application/json"
    puts "Current user is #{@current_user}"
  	# redirect_to login_path unless session[:user_id] != nil && User.find(session[:user_id])
  end



  def report_com
    puts "report com"
    begin
      station = Station.find(params[:id])

      station.update(latest_com: Time.now)
    rescue
      puts params.inspect
    end
  end


end
