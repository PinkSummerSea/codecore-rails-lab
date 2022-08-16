class Api::V1::ProductsController < Api::ApplicationController

    
    before_action :authenticate_user!, except: [:index, :show]

    def index
        products = Product.order created_at: :desc
        render json:products
    end

    def show
        product = Product.find params[:id]
        render json:product
    end

    def create
        product = Product.new params.require(:product).permit!
        product.user = current_user
        if product.save
            render json: {id: product.id}
        else  
            render(
                json: { errors: product.errors.messages },
                status: 422
            )
        end
    end

    def update
        product = Product.find params[:id]
        if product.update params.require(:product).permit!
            render json: {id: product.id}
        else  
            render(
                json: { errors: product.errors.messages },
                status: 422
            )
        end
    end

    def destroy
        product = Product.find params[:id]
        if product.destroy
           render json: {stauts: 200}
        else 
            render json: {stauts: 500}
        end
    end

    
end
