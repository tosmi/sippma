class EntryLine < ActiveRecord::Base
  belongs_to :invoice, inverse_of: :entry_lines

  validates :text, presence: true, length: { maximum: 50 }
  validates_numericality_of :amount
  validates_numericality_of :fee, allow_blank: true
  validates_presence_of :invoice
end
