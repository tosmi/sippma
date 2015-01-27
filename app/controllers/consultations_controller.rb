class ConsultationsController < ApplicationController
  def new
    @patient = Patient.find(params[:patient_id])
    @consultation = @patient.consultations.build
  end

  def create
    @patient = Patient.find(params[:id])
    @consultation = @patient.consultations.build(consultation_params)
    if @consultation.save
      flash[:success] = "Consultation for #{@patient.firstname} #{@patient.lastname} saved!"
      redirect_to patients_path
    else
      render 'new'
    end
  end

  private

  def consultation_params
    params.require(:consultation).permit(:content, :diagnosis)
  end
end
