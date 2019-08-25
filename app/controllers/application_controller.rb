class ApplicationController < ActionController::Base

    def login
        @user = User.new
    end

    def create
        binding.pry
        if @user = User.find_by(email: params[:emaill])
            session[:user_id] = @user.id
            redirect_to @user
        end
    end
end
