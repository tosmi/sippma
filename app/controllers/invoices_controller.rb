class InvoicesController < ApplicationController
  before_action :logged_in_user

  def new
    invoice.entry_lines.build
    if not patient.consultations.empty?
      invoice.diagnosis = patient.consultations.first.diagnosis
    end

    @invoicenumber = "#{Setting.new_invoicenumber}-#{Date.today.strftime('%d-%m-%y')}"
  end

  def create
    if invoice.save
      Setting.create_invoicenumber
      flash[:success] = 'Invoice successfully saved'
      redirect_to patients_url
    else
      @invoicenumber = params[:invoice][:invoicenumber]
      invoice.entry_lines.build if invoice.entry_lines.empty?
      render 'new'
    end
  end

  def index
    @invoices = patient.invoices.all
  end

  protected

  def patient
    @patient ||= Patient.find(params[:patient_id])
  end

  def invoice
    @invoice ||= patient.invoices.build(invoice_params)
  end

  def settings
    @settings ||= Setting.instance
  end

  helper_method :patient, :invoice, :settings

  private

  def invoice_params
    if params.has_key?(:invoice)
      params.require(:invoice).permit(:diagnosis,
                                      :sum,
                                      :date,
                                      :invoicenumber,
                                      :totalfee,
                                      entry_lines_attributes: [
                                        :id,
                                        :text,
                                        :fee,
                                      ])
    end
  end
end
