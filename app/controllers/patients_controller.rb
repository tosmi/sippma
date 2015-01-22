class PatientsController < ApplicationController

  def index
    if not Patient.any?
      render 'welcome'
    end
    @patients = Patient.all
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      flash[:success] = 'Successfully saved new patient'
      redirect_to patients_url
    else
      render 'new'
    end
  end

  def destroy
    Patient.find(params[:id]).destroy
    flash[:success] = "Patient deleted"
    redirect_to patients_url
  end

  private

  def patient_params
    params.require(:patient).permit(:firstname,
                                    :lastname,
                                    :zip,
                                    :city,
                                    :street,
                                    :ssn,
                                    :insurance,
                                    :phonenumber1,
                                    :phonenumber2,
                                    :birthdate,
                                    :email)
  end
end
