class ChefsController < ApplicationController
	before_action :set_chef, only: [:edit, :show]
	before_action :require_same_user, olny: [:eidt, :update]

	def index
		@chefs = Chef.paginate(page: params[:page], per_page: 3)
	end

	def new
		@chef = Chef.new
	end

	def create
		@chef = Chef.new(chef_params)
		if @chef.save
			flash[:success] = "Your Account Has Been Create Successfully!"
			session[:chef_id] = @chef.id
			redirect_to recipes_path
		else
			render :new
		end
	end

	def edit

	end

	def update
		if @chef.update(chef_params)
			flash[:success] = "Your Account Has Been Updated"
			redirect_to chef_path(@chef)
		else
			render :edit
		end
	end

	def show
		@recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
	end

	private
		def chef_params
			params.require(:chef).permit(:chef_name, :email, :password, :picture)
		end

		def set_chef
			@chef = Chef.find(params[:id])
		end

		def require_same_user
			if current_user != @chef
				flash[:danger] = "You can only edit your own profile"
				redirect_to :back
			end
		end

end