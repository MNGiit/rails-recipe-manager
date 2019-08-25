class SessionsController < ApplicationController
    def new
        @user = User.new
    end
 
    def create
        binding.pry
        redirect_to '/'
    end
end