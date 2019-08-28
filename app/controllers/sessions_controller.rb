class SessionsController < ApplicationController
    def new
        if !session[:user_id]
            @user = User.new
        else
            redirect_to root_path
        end
    end
 
    def create
        if auth
            name = auth[:extra][:raw_info][:login]
            email = name + "@github.com"
            # .find_by(:email => email)
            if @user = User.find_by(email: email)
                session[:user_id] = @user.id
                # @user = find_or_make(email: email)
                redirect_to @user
            else
                @user = User.create(email: email, name: name, password: SecureRandom.hex)
                if @user.save
                    session[:user_id] = @user.id
                    redirect_to @user
                else
                    redirect_to login_path
                end
            end
        else
            @user = User.find_by(email: params[:user][:email])
            if @user && @user.authenticate(params[:user][:password])
                session[:user_id] = @user.id
                redirect_to @user # redirect_to user_path(@user)
            else
                redirect_to login_path
            end
        end
    end

    def destroy
        session.clear
        redirect_to login_path
    end
    
    private

    def auth
        request.env['omniauth.auth']
    end
end