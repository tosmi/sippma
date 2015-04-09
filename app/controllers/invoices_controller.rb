class InvoicesController < ApplicationController
  before_action :logged_in_user

  def new
    @patient = Patient.find(params[:patient_id])
    @consultation = @patient.consultations.first
    @settings = Setting.instance

    @invoice = @patient.invoices.build
    @invoice.diagnosis ||= @consultation.diagnosis if @consultation
    @invoice.entry_lines.build

    @invoicenumber = "#{Setting.new_invoicenumber}-#{Date.today.strftime('%d-%m-%y')}"
  end

  def create
    @patient = Patient.find(params[:patient_id])
    @invoice = @patient.invoices.build(invoice_params)
    if @invoice.save
      flash[:success] = 'Invoice successfully saved'
      redirect_to patients_url
    else
      @invoicenumber = params[:invoice][:invoicenumber]
      @settings = Setting.instance
      @invoice.entry_lines.build if not params[:invoice].has_key? :entry_lines_attributes
      render 'new'
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:diagnosis,
                                    :sum,
                                    :date,
                                    :invoicenumber,
                                    entry_lines_attributes: [
                                      :id,
                                      :text,
                                      :fee,
                                    ])
  end
end
