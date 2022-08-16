class Api::ApplicationController < ApplicationController
    skip_before_action :verify_authenticity_token
 
    def authenticate_user!
        redirect_to new_session_path, notice: "Please Sign In" unless user_signed_in?
    end
end
