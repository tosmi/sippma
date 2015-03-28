class Setting < ActiveRecord::Base
  before_save :format_email

  include SippmaRegex

  validates :title, length: { maximum: 20 }, :allow_blank => true

  validates :firstname, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }, :allow_blank => true
  validates :lastname, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }, :allow_blank => true

  validates :city, length: { maximum: 50}, :allow_blank => true
  validates :street, length: { maximum: 50}, :allow_blank => true

  validates :phonenumber, length: { maximum: 30}, format: { with: VALID_PHONENUMBER_REGEX }, :allow_blank => true

  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, :allow_blank => true

  private_class_method :new, :create, :create!

  def Setting.instance
    setting = first || create

    init_invoicenumber(setting) if invoicenumber_needs_initialization? setting

    setting
  end

  def Setting.create_invoicenumber
    setting = Setting.instance
    setting.increment!(:current_invoicenumber)
    setting.current_invoicenumber
  end

  def Setting.new_invoicenumber
    Setting.instance.current_invoicenumber + 1
  end

  class << self
    private

    def invoicenumber_needs_initialization?(setting)
      return true if setting.current_invoicenumber.nil?

      if not setting.initial_invoicenumber.nil?
        return true if (setting.current_invoicenumber < setting.initial_invoicenumber)
      end
    end

    def init_invoicenumber(setting)
      setting.current_invoicenumber =
        if not setting.initial_invoicenumber.nil?
          setting.initial_invoicenumber - 1
        else
          0
        end

      setting.save
    end

  end

  private

  def format_email
    self.email = email.downcase if not email.nil?
  end

end
