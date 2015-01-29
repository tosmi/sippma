class ConsultationsController < ApplicationController
  before_action :logged_in_user

  def new
    @patient = Patient.find(params[:patient_id])
    @consultation = @patient.consultations.build
  end

  def index
    @patient = Patient.find(params[:patient_id])
    @consultations = @patient.consultations.all
  end

  def create
    @patient = Patient.find(params[:patient_id])
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
