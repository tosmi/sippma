class InvoicesController < ApplicationController
  def new
    @patient = Patient.find(params[:patient_id])
    @invoice = @patient.invoices.build
    @settings = Setting.instance
    @invoicenumber = "#{Setting.new_invoicenumber}-#{Date.today.strftime('%d-%m-%y')}"
    @consultation = @patient.consultations.first
  end
end
