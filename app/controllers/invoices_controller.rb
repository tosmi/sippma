class InvoicesController < ApplicationController
  before_action :logged_in_user

  def new
    @patient = Patient.find(params[:patient_id])
    @invoice = @patient.invoices.build
    @settings = Setting.instance
    @invoicenumber = "#{Setting.new_invoicenumber}-#{Date.today.strftime('%d-%m-%y')}"
    @consultation = @patient.consultations.first
  end

  def create
  end
end
