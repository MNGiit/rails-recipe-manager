class ApplicationController < ActionController::Base

    def login
        @user = User.new
    end

end
