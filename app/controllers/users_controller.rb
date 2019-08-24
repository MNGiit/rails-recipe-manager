class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        @user = User.find_by(params[:id])
    end

    def new
    end

    def crete
    end

    def edit
    end

    def update
    end

end
