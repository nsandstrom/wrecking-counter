class CalibrationCodesController < ApplicationController
	def index
		@calibration_codes = CalibrationCode.all.order(created_at: "desc").limit(100)
	end

	def active
		@calibration_codes = CalibrationCode.where(completed: false).order(created_at: "desc").limit(100)
		@active = true
		render "index"
	end

	def destroy
		CalibrationCode.find(params[:id]).destroy
		redirect_to calibration_codes_url, notice: 'Code deleted.'
	end
end
