class SessionsController < ApplicationController

	def new
		
	end

	def create
		session[:user] = {id: nil, type: nil} # What is this called again? Hash object or just hash (Ruby version of objects or associative arrays)
		user = Lender.find_by(email: sessions_params[:email])
		if user.nil?
			user = Borrower.find_by(email: sessions_params[:email])
			if user.nil?
				session[:user] = nil # Delete hash object
				flash[:error] = "Invalid Email/Password Combination" # Couldn't find email
				redirect_to "/sessions/new" and return # "/"?
			else
				session[:user][:type] = "borrower"
				url = "/borrowers/"
			end
		else
			session[:user][:type] = "lender"
			url = "/lenders/"
		end
		if user.authenticate(sessions_params[:password])
			session[:user][:id] = user.id
			url += "#{user.id}"
			redirect_to url
		else
			session[:user] = nil
			flash[:error] = "Invalid Email/Password Combination" # Couldn't find password
			redirect_to "/sessions/new"
		end
	end

	def destroy
		session[:user] = nil
		redirect_to "/"
	end

	private

	def sessions_params
		params.require(:user).permit(:email, :password)
	end

end