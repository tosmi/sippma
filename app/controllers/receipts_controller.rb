class ReceiptsController < ApplicationController
  def new
    @patient = Patient.find(params[:patient_id])
    @receipt = @patient.receipts.build
    @settings = Setting.instance
    @receiptnumber = "#{@settings.current_receiptnumber+1}-#{Date.today.strftime('%Y-%m-%d')}"
  end
end
