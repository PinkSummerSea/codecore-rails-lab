class ReviewsController < ApplicationController
    before_action :find_product
    before_action :authenticate_user!

    def create
        @review = Review.new(params.require(:review).permit(:rating, :body))
        @review.product = @product
        @review.user = current_user
        if @review.save
            # ProductMailer.review_notification(@review).deliver_now
            ProductMailer.delay(run_at: 2.minutes.from_now).review_notification(@review)
            redirect_to product_path(@product), notice: "Review Created"
        else  
            @reviews = @product.reviews.order(created_at: :desc)
            render 'products/show', status: 303 # what's the purpose for 303. for errors to occur?
        end
    end

    def edit
        @review = Review.find(params[:id])
    end

    def update
        @review = Review.find(params[:id])
        if @review.user == current_user || current_user.is_admin
            if @review.update(review_params)
                redirect_to product_path(@product)
              else 
                render :edit
              end
        end
    end


    def change
        @review = Review.find(params[:id])
        if @product.user == current_user
            @review.hidden = !@review.hidden
            if @review.save
                redirect_to product_path(@product)
            end
        end
    end


    def destroy
        @review = Review.find(params[:id])

        if can?(:crud, @review)
            if @review.destroy
                redirect_to product_path(@product), notice: "Review Deleted"
            end
        else
            redirect_to product_path(@product), notice: "Not Authorized To Delete This"
        end
    end

    private

    def find_product
        @product = Product.find(params[:product_id])
    end

    def review_params
        params.require(:review).permit!
    end
end
