class ApplicationController < ActionController::Base

	helper_method :current_user, :logged_in?

	def current_user
		@current_user  ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!current_user #will turn the current user result into boolean
	end

	def authenticate_user
		if !logged_in?
			flash[:alert] = "You must be logged in to perform this action."
			redirect_to login_path
		end
	end
end
