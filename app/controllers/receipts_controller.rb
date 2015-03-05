class ReceiptsController < ApplicationController
  def new
    @patient = Patient.find(params[:patient_id])
    @receipt = @patient.receipts.build
  end
end
