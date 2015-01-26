class ConsultationsController < ApplicationController
  def new
    @patient = Patient.find(params[:patient_id])
    @consultation = @patient.consultations.build
  end
end
