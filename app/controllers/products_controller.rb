class ProductsController < ApplicationController
    before_action :find_product, only: [:edit, :update, :show, :destroy, :authorize_user!]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only: [:edit, :update, :destroy]

    def new
        @product = Product.new
    end

    def create 
        @product = Product.new(product_params)
        @product.user = current_user
        if @product.save
            flash[:notice] = "Successfully created a new product!"
            redirect_to product_path(@product)
        else 
            render :new
        end
    end

    def index
        @products = Product.order(updated_at: :desc)
    end

    def show
        @reviews = @product.reviews.order(created_at: :desc)
        @review = Review.new
    end

    def edit
    end

    def update
      if @product.update(product_params)
        redirect_to product_path(@product)
      else 
        render :edit
      end


      
    end

    def destroy
        @product.destroy
        redirect_to products_path, notice: "Product Deleted"
    end

    private

    def authorize_user!
        redirect_to product_path(@product), notice: "Not Authorized" unless can?(:crud, @product)
    end

    def find_product
        @product = Product.find params[:id]
    end

    def product_params
        params.require(:product).permit(:title, :description, :price, :sale_price, :image_file)
    end
end
