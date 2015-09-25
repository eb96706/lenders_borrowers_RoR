class BorrowersController < ApplicationController

  def show
    @borrower = Borrower.find(params[:id])
    @amount = @borrower.money.sum(:amount)
  end

  def create
  	new_borrower = Borrower.new(borrower_params)
    new_borrower.amount_raised = 0
  	if new_borrower.save
  		flash[:borrower_notice] = "You have successfully registered as a Borrower!"
  		redirect_to "/"
  	else
  		flash[:borrower_errors] = new_borrower.errors.full_messages
  		redirect_to "/"
  	end
  end

  private

  def borrower_params
  	params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :purpose, :desc, :amount_needed, :amount_raised)
  end

end
