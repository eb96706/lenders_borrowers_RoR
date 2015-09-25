class Borrower < ActiveRecord::Base

  has_secure_password

  has_many :money
  has_many :lenders, through: :money

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :purpose, :desc, :amount_needed, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

  validate :email_is_unique

  def email_is_unique
  	if Lender.where(email: email).present?
  		errors.add(:email, 'is already registered.')
  	end
  end

end
