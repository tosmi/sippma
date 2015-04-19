class Invoice < ActiveRecord::Base
  has_many :entry_lines, inverse_of: :invoice
  belongs_to :patient

  accepts_nested_attributes_for :entry_lines, allow_destroy: true, reject_if: :all_blank

  default_scope -> { order('created_at DESC') }

  validates :patient_id, presence: true
  validates :diagnosis, length: { maximum: 200 }, presence: true

  VALID_INVOICE_NUMBER = /\A\d+-\d{2}-\d{2}-\d{2}\z/
  validates :invoicenumber, presence: true, format: { with: VALID_INVOICE_NUMBER }

  validates :date, presence: true

  validates :totalfee, presence: true

end
