class Receipt < ActiveRecord::Base
  belongs_to :patient
  default_scope -> { order('created_at DESC') }
  validates :patient_id, presence: true
  validates :diagnosis, length: { maximum: 200 }

  VALID_RECEIPT_NUMBER = /\A\d+-\d{1,2}-\d{1,2}-\d{4}\z/
  validates :receiptnumber, presence: true, format: { with: VALID_RECEIPT_NUMBER }

end
