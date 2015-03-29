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
    p params
    redirect_to patients_url
  end

  private

  def invoice_params
    params.require(:invoice).permit(:diagnosis,
                                    :entries,
                                    :fees,
                                    :sum,
                                    :patient_id,
                                    :commit,
                                    :invoicenumber)
  end
end
