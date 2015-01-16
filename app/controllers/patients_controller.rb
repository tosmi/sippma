class PatientsController < ApplicationController

  def index
    if not Patient.any?
      render 'welcome'
    end
  end

  def show
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
                                    :email)
  end
end
