class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        if !session[:user_id]
            @user = User.new
        else
            redirect_to root_path
        end
    end

    def create
        # binding.pry
        # => <ActionController::Parameters {"name"=>"Adam", "email"=>"adam@gmail.com", "password"=>"password"} 
        # permitted: false>
        # @user = User.find_or_create_by(email: user_params[:email])
        # binding.pry # remember there isn't a @user yet
        @user = User.create(user_params) # testing validations
        # binding.pry
        # if User.find_by(email: user_params[:email])
            # message = "Email already in use. Try another email."
        #     render :new # render 'new'
        # else
        #     @user = User.create(user_params)
        #     redirect_to user_path(@user) # redirect_to @user
        # end
        if @user.valid?
            session[:user_id] = @user.id
            redirect_to @user # redirect_to user_path(@user)
        else
            render '/users/new'# new_user_path # :new
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
