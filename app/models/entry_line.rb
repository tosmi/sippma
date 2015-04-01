class EntryLine < ActiveRecord::Base
  belongs_to :invoice

  validates :text, presence: true, length: { maximum: 50 }
  validates_numericality_of :fee

end
