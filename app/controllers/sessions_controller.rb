class SessionsController < ApplicationController
	before_action :check_user_logged_in, only: [:create, :new]

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:notice] = "Successfully logged in"
			redirect_to user_path(user)
		else
			flash.now[:alert] = "Email or password is incorrect. Please enter credentials again."
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "Successfully logged out"
		redirect_to root_path
	end

	private
	def check_user_logged_in
		redirect_to root_path if logged_in?
	end
end