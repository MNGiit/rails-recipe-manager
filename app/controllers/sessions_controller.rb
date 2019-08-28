class SessionsController < ApplicationController
    def new
        if !session[:user_id]
            @user = User.new
        else
            redirect_to root_path
        end
    end
 
    def create
        binding.pry
        @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:password])
          session[:user_id] = @user.id
          redirect_to @user # redirect_to user_path(@user)
        else
          redirect_to login_path
        end
    end

    def destroy
        session.clear
        binding.pry
        redirect_to login_path
    end
end