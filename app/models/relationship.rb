class Relationship < ActiveRecord::Base
  belongs_to :patient
  belongs_to :parent, class_name: 'Patient'

  validates :parent_id, presence: true
  validates :patient_id,  presence: true

  validates :parent_id, uniqueness: {scope: :patient_id}
end
