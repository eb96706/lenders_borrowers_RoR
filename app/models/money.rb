class Money < ActiveRecord::Base

  belongs_to :lender, validate: true # Every time you make a new entry in the db, you must have a lender
  belongs_to :borrower, validate: true # Every time you make a new entry in the db, you must have a borrower
  
  validates :amount, presence: true, numericality: {only_integer: true, greater_than: 9}
  validate :amount_is_multiple_of_ten
  validate :cannot_exceed_user_limits

  def amount_is_multiple_of_ten
  	unless amount.nil?
      if amount%10 != 0
      	errors.add(:amount, "must be a multiple of ten")
      end
	end
  end

  def cannot_exceed_user_limits
  	unless amount.nil?
	  	if ! borrower.nil? and borrower.amount_needed < borrower.money.sum(:amount) + amount
	  		errors.add(:amount, "can't exceed amount needed!")
	  	end
	  	if ! lender.nil? and lender.money_amount < lender.money.sum(:amount) + amount
	  		errors.add(:amount, "can't lend more than funds available!")
	  	end
	end
  end

end
