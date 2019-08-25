class ApplicationController < ActionController::Base

    def login
        @user = User.new
    end

    def create
        @user = User.find_by(email: params[:email])
        binding.pry
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect_to @user # redirect_to user_path(@user)
        else
          redirect_to signin_path
        end
    end

end
