class CategoriesController < ApplicationController
	before_action :set_category, only: [:show]
	before_action :require_admin, except: [:index, :show]

	def index
		@categories = Category.paginate(page: params[:page], per_page: 5)
	end

	def show
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)

		if @category.save
			flash[:notice] = "Category was successfulluy created"
			redirect_to category_path(@category)
		else
			render 'new'
		end
	end

	private
	def category_params
		params.require(:category).permit(:name)
	end

	def set_category
		@category = Category.find(params[:id])
	end

	def require_admin
		if !(logged_in? && current_user.admin?)
			flash[:alert] = "Only admins can perfom this action."
			redirect_to categories_path
		end
	end
end
