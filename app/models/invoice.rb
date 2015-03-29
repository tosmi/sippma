class Invoice < ActiveRecord::Base
  belongs_to :patient

  default_scope -> { order('created_at DESC') }

  validates :patient_id, presence: true
  validates :diagnosis, length: { maximum: 200 }

  VALID_INVOICE_NUMBER = /\A\d+-\d{1,2}-\d{1,2}-\d{4}\z/
  validates :invoicenumber, presence: true, format: { with: VALID_INVOICE_NUMBER }

  validates :date, presence: true

end
