class RoundsController < ApplicationController
  require 'rake'
  before_action :set_round, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  # GET /rounds
  # GET /rounds.json
  def index
    @rounds = Round.all
    @stations = Station.all
  end

  # GET /rounds/1
  # GET /rounds/1.json
  def show
  end

  def create

      puts "trying to start new"
    # load Rails.root.join('lib', 'tasks', 'gameround.rake')
    # load Rails.root.join('Rakefile')
    # puts "My raketask!  #{Rake::Task["gameround:run"].invoke}"
    round = Round.order('endtime desc').first
    round_params = params[:round]
    starttime = Time.new(round_params["starttime(1i)"],
                          round_params["starttime(2i)"],
                          round_params["starttime(3i)"],
                          round_params["starttime(4i)"],
                          round_params["starttime(5i)"])
    starttime -= Time.zone.now.utc_offset unless Rails.env=="development"
    runtime = params[:round][:length].to_i
    puts "start time #{params[:round][:Starttime]}"

    stations = 0
    params[:stations].each do |station|
      id = station.first.to_i
      stations = (stations | (1<<(id-1)))
    end

    # unless round && round.active
       Round.create(name: "Test round",starttime: starttime, endtime: (starttime + runtime.minutes).utc, active: false, stations: stations )
      
    # end

    
    # head 202
    redirect_to rounds_path

  end

  # GET /rounds/new
  def new_old
    @round = Round.new
  end

  # GET /rounds/1/edit
  def edit
  end

  # POST /rounds
  # POST /rounds.json
  def create_old
    @round = Round.new(round_params)

    respond_to do |format|
      if @round.save
        format.html { redirect_to @round, notice: 'Round was successfully created.' }
        format.json { render :show, status: :created, location: @round }
      else
        format.html { render :new }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rounds/1
  # PATCH/PUT /rounds/1.json
  def update
    respond_to do |format|
      if @round.update(round_params)
        format.html { redirect_to @round, notice: 'Round was successfully updated.' }
        format.json { render :show, status: :ok, location: @round }
      else
        format.html { render :edit }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    @round.destroy
    respond_to do |format|
      format.html { redirect_to rounds_url, notice: 'Round was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def round_params
      params.require(:round).permit(:name, :active, :starttime, :endtime, :score)
    end
end
