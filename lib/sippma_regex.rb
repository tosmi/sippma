module SippmaRegex
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  VALID_NAME_REGEX = /\A[a-zA-Z]+\s?([a-zA-Z]+\s)*[a-zA-Z]+\z/i
  VALID_ZIP_REGEX = /\A\d{1,5}\z/
  VALID_PHONENUMBER_REGEX = /\A\+?\d+([-\s\/]?\d+)*\d\z/
end
