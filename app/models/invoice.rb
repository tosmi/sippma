class Invoice < ActiveRecord::Base
  has_many :entry_lines, inverse_of: :invoice
  belongs_to :patient

  belongs_to :parent, class_name: Patient, foreign_key: 'parent_id'

  accepts_nested_attributes_for :entry_lines, allow_destroy: true, reject_if: :all_blank

  default_scope -> { order('created_at DESC') }

  validates :patient_id, presence: true
  validates :diagnosis, length: { maximum: 200 }, presence: true

  validates_numericality_of :parent_id, allow_blank: true

  VALID_INVOICE_NUMBER = /\A\d+-\d{2}-\d{2}-\d{2}\z/
  validates :invoicenumber, presence: true, format: { with: VALID_INVOICE_NUMBER }

  validates :date, presence: true

  validates :totalfee, presence: true

end
