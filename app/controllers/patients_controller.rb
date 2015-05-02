class PatientsController < ApplicationController
  before_action :logged_in_user

  def index
    if not Patient.any?
      render 'welcome'
    else
      @patients = Patient.search(params[:search])
    end
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

  def edit
    @patient = Patient.find(params[:id])
    @parents = Patient.all
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(patient_params)
      flash[:success] = "Patient updated"
      redirect_to patients_url
    else
      render 'edit'
    end
  end

  def destroy
    Patient.find(params[:id]).destroy
    flash[:success] = "Patient deleted"
    redirect_to patients_url
  end

  def parent_search
    @patients = Patient.search(params[:search])
    respond_to do |format|
      format.html
      format.js
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
                                    :birthdate,
                                    :email)
  end
end
