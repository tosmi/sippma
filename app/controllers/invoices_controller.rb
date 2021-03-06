class InvoicesController < ApplicationController
  before_action :logged_in_user

  def new
    invoice.entry_lines.build
    @parents = Patient.where id: patient.parent_ids
    if not patient.consultations.empty?
      invoice.diagnosis = patient.consultations.first.diagnosis
    end

    invoice.invoicenumber = "#{Setting.new_invoicenumber}-#{Date.today.strftime('%d-%m-%y')}"
    invoice.date = Date.today
    invoice.consultation_date = Date.today
  end

  def create
    if invoice.save
      Setting.create_invoicenumber
      flash[:success] = 'Invoice successfully saved'
      redirect_to invoice_url(invoice)
    else
      invoice.entry_lines.build if invoice.entry_lines.empty?
      @parents = Patient.where id: patient.parent_ids
      render 'new'
    end
  end

  def index
    unless patient.invoices.any?
      render 'welcome'
    else
      @invoices = patient.invoices.all
    end
  end

  def show
    @patient = Patient.find(invoice.patient_id)
    if params[:print] == 'true'
      @print = true
    else
      @print = false
    end
  end

  def edit
    @patient = Patient.find(invoice.patient_id)
    @parents = Patient.where id: patient.parent_ids
    invoice
  end

  def update
    if invoice.update(invoice_params)
      flash[:success] = 'Invoice updated'
      redirect_to patient_invoices_path(invoice.patient_id)
    else
      render 'edit'
    end
  end

  def destroy
    invoice.destroy
    flash[:success] = "Invoice deleted"
    redirect_to patient_invoices_path(invoice.patient_id)
  end

  protected

  def patient
    if params.has_key? :patient_id
      @patient ||= Patient.find(params[:patient_id])
    elsif not @invoice.nil?
      @patient ||= Patient.find(@invoice.patient_id)
    end
  end

  def invoice
    @invoice ||= Invoice.find(params[:id])

    rescue
      @invoice ||= patient.invoices.build(invoice_params)
  end

  def settings
    @settings ||= Setting.instance
  end

  helper_method :patient, :invoice, :settings

  private

  def invoice_params
    if params.has_key?(:invoice)
      params.require(:invoice).permit(
        :diagnosis,
        :sum,
        :date,
        :consultation_date,
        :invoicenumber,
        :totalfee,
        :parent_id,
        :print,
        entry_lines_attributes: [
          :id,
          :amount,
          :text,
          :fee,
        ])
    end
  end
end
