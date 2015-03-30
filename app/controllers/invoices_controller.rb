class InvoicesController < ApplicationController
  before_action :logged_in_user

  def new
    @patient = Patient.find(params[:patient_id])
    @consultation = @patient.consultations.first
    @settings = Setting.instance

    @invoice = @patient.invoices.build
    @invoice.diagnosis ||= @consultation.diagnosis if @consultation

    @invoicenumber = "#{Setting.new_invoicenumber}-#{Date.today.strftime('%d-%m-%y')}"
  end

  def create
    p params
    @patient = Patient.find(params[:patient_id])
    @invoice = @patient.invoices.build(invoice_params)

    if @invoice.save
      flash[:success] = 'Invoice successfully saved'
      redirect_to patients_url
    else
      p 'here'
      @settings = Setting.instance
      render 'new'
    end
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
