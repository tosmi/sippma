class Consultation < ActiveRecord::Base
  belongs_to :patient
  default_scope -> { order('date DESC')}
  validates :patient_id, presence: true
  validates :date, presence: true
end
