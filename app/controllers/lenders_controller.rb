class LendersController < ApplicationController

  def show
    @lender = Lender.find(params[:id])
    @balance = @lender.money_amount - @lender.money.sum(:amount)
    @borrowers = Borrower.all
  end

  def create
  	new_lender = Lender.create(lender_params)
  	if new_lender.valid?
  		flash[:lender_notice] = "You have successfully registered as a Lender!"
  		redirect_to "/"
  	else
  		flash[:lender_errors] = new_lender.errors.full_messages
  		redirect_to "/"
  	end
  end

  def create_money
    new_money = Money.new(money_params)
    # puts session[:user]["id"]
    # fail
    new_money.lender = Lender.find(session[:user]["id"])
    if new_money.save
      new_money.borrower.amount_raised += new_money.amount
      redirect_to "/lenders/#{session[:user]["id"]}"
    else
      flash[:errors] = new_money.errors.full_messages
      redirect_to "/lenders/#{session[:user]["id"]}"
    end
  end

  def update_money
    
  end

  def destroy_money
    
  end

  private

    def lender_params
    	params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money_amount)
    end

    def money_params
      params.require(:money).permit(:amount, :borrower_id)
    end

end
