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
    @mother  = Patient.new
    @father  = Patient.new
  end

  def create
    @inputerror = false

    p patient_params
    @patient = Patient.new(patient_params.except(:mother).except(:father))
    @mother  = Patient.new(patient_params[:mother])
    @father  = Patient.new(patient_params[:father])

    @inputerror = true unless @patient.valid?

    p @mother
    unless @mother.firstname.nil?
      @inputerror = true unless @mother.valid?
    end

    p "inputerror: #{@inputerror}"

    # inputerror = true unless @father.valid?

    if @inputerror
      render 'new'
    else
      @patient.save
      @mother.save if @mother.firstname
      @father.save if @father.firstname

      flash[:success] = 'Successfully saved new patient'
      redirect_to patients_url
    end
  end

  def edit
    @patient  = Patient.find(params[:id])
    @patients = Patient.page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @patient = Patient.find(params[:id])
    @patients = Patient.page(params[:page]).per(5)
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
    @patients = Patient.search(params[:search]).page(params[:page]).per(5)
    @patient_id = params[:patient_id]

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def patient_params
    params.require(:patient).permit(
      :firstname,
      :lastname,
      :zip,
      :city,
      :street,
      :ssn,
      :insurance,
      :phonenumber1,
      :phonenumber2,
      :birthdate,
      :email,
      :patient_id,
      :page,
      mother: [
        :firstname,
        :lastname,
        :ssn,
        :insurance
      ],
      father: [
        :firstname,
        :lastname,
        :ssn,
        :insurance
      ]
      )
  end
end
