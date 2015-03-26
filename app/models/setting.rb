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
    first || create
  end

  def Setting.next_receiptnumber
    setting = Setting.instance
    init_receiptnumber if setting.current_receiptnumber.nil?

    setting.reload

    setting.increment!(:current_receiptnumber)
    setting.current_receiptnumber
  end

  class << self
    private

    def init_receiptnumber
      setting = Setting.instance
      if not setting.initial_receiptnumber.nil?
        setting.current_receiptnumber = setting.initial_receiptnumber - 1
        setting.save
      end
    end

  end

  private

  def format_email
    self.email = email.downcase if not email.nil?
  end

end
