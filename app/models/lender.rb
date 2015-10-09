class Lender < ActiveRecord::Base

  has_secure_password

  has_many :money
  has_many :borrowers, through: :money

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :money_amount, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :money_amount, numericality: {greater_than: 9, message: "must have funds to lend"}
  validate :email_is_unique
  validate :amount_is_multiple_of_ten, if: 'money_amount.present?'

  def email_is_unique
  	if Borrower.where(email: email).present?
  		errors.add(:email, 'is already registered.')
  	end
  end

  def amount_is_multiple_of_ten
    if money_amount%10 != 0
      errors.add(:money_amount, "must be a multiple of ten")
    end
  end

end
