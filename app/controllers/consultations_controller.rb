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
      redirect_to patient_consultations_path(@patient)
    else
      render 'new'
    end
  end

  def edit
    @consultation = Consultation.find(params[:id])
    @patient = Patient.find(@consultation.patient_id)
  end

  def update
    @consultation = Consultation.find(params[:id])
    @patient = Patient.find(@consultation.patient_id)
    if @consultation.update_attributes(consultation_params)
      flash[:success] = 'Consultation updated'
      redirect_to patient_consultations_path(@patient)
    else
      render 'edit'
    end
  end

  def destroy
    @consultation = Consultation.find(params[:id])
    patient_id = @consultation.patient_id
    @consultation.destroy
    flash[:success] = "Consultation deleted"
    redirect_to patient_consultations_path(patient_id)
  end

  private

  def consultation_params
    params.require(:consultation).permit(:content, :diagnosis)
  end
end
