class Patient < ActiveRecord::Base
  has_many :consultations
  has_many :invoices

  has_many :relationships
  has_many :parents, through: :relationships

  has_many :child_relationships, class_name: 'Relationship', foreign_key: 'parent_id'
  has_many :children, through: :child_relationships, source: :patient

  include SippmaRegex
  default_scope { order('lastname DESC') }

  before_save { self.email = email.downcase }

  validates :firstname, presence: true, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }
  validates :lastname, presence: true, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }

  validates :zip, presence: true, length: { maximum: 5}, format: { with: VALID_ZIP_REGEX }

  validates :city, presence: true, length: { maximum: 50}
  validates :street, presence: true, length: { maximum: 50}

  validates :phonenumber1, length: { maximum: 30}, format: { with: VALID_PHONENUMBER_REGEX }, :allow_blank => true
  validates :phonenumber2, length: { maximum: 30}, format: { with: VALID_PHONENUMBER_REGEX }, :allow_blank => true

  validates :insurance, presence: true, length: { maximum: 50}, format: { with: VALID_NAME_REGEX }

  VALID_SSN_REGEX = /\A\d{1,5}\z/
  validates :ssn, presence: true, length: { maximum: 5}, format: { with: VALID_SSN_REGEX }

  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, :allow_blank => true

  validates :birthdate, presence: true

  def parent(parent)
    relationships.create(parent_id: parent.id)
  end

  def child(child)
    child_relationships.create(patient_id: child.id)
  end

  def parent_of?(child)
    children.include?(child)
  end

  def child_of?(parent)
    parents.include?(parent)
  end

  def self.search(search)
    if search and not search.empty?
      searchterms = search.split
      if searchterms.length > 1
        *f, lastname = searchterms
        firstname = f.join(' ')
        result = where("firstname like ? and lastname like ?", "#{firstname}%", "#{lastname}%")
      else
        result = where("firstname like ? or lastname like ?", "#{searchterms[0]}%", "#{searchterms[0]}%")
      end
      puts "\n\n\nsearchterms: <#{searchterms}> firstname: <#{firstname}> lastname: <#{lastname}>\n\n\n"
      result
    else
      all
    end
  end

end
