class Api::V1::UsersController < Api::ApplicationController

    def current
        p current_user
        
        render json: current_user
    end
end
