class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        binding.pry
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        # binding.pry
        # => <ActionController::Parameters {"name"=>"Adam", "email"=>"adam@gmail.com", "password"=>"password"} 
        # permitted: false>
        # @user = User.find_or_create_by(email: user_params[:email])
        @user = User.find_by(email: user_params[:email])
        if @user
            message = "Email already in use. Try another email."
            redirect_to new_user_path # render 'new'
        else
            @user = User.create(user_params)
            redirect_to user_path(@user) # redirect_to @user
        end
    end

    def edit
    end

    def update
    end
    
    private

    def user_params
        params.require(:user).permit(:name, :email, :password)
    end

end
