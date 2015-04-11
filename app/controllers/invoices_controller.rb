class InvoicesController < ApplicationController
  before_action :logged_in_user

  def new
    @consultation = patient.consultations.first

    invoice.diagnosis ||= @consultation.diagnosis if @consultation
    invoice.entry_lines.build

    @invoicenumber = "#{Setting.new_invoicenumber}-#{Date.today.strftime('%d-%m-%y')}"
  end

  def create
    if invoice.save
      flash[:success] = 'Invoice successfully saved'
      redirect_to patients_url
    else
      @invoicenumber = params[:invoice][:invoicenumber]
      invoice.entry_lines.build if not entry_lines?
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

  def entry_lines?
    if (not params[:invoice].has_key? :entry_lines_attributes) or params[:invoice][:entry_lines_attributes]['0'][:text].empty?
      return false
    end

    return true
  end

  def invoice_params
    if params.has_key?(:invoice)
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
end
