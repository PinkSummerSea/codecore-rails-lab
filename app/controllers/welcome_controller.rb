class WelcomeController < ApplicationController
    before_action :authorize_user!, only: [:admin_panel]
    
    def home
    end

    def about
    end

    def contact_us
    end

    def thank_you
    end

    def admin_panel
        @users = User.all
        @users_count = User.count
        @products = Product.all
        @products_count = Product.count
        @reviews = Review.all
        @reviews_count = Review.count
    end

    private

    def authorize_user!
        redirect_to root_path, notice: "Not Authorized" unless current_user && current_user.is_admin
    end

end
