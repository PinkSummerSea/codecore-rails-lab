class LikesController < ApplicationController

    before_action :authenticate_user!

    def create
        @like = Like.new
        @review = Review.find params[:review_id]
        @like.review = @review
        @like.user = current_user
        @product = Product.find params[:product_id]
        if cannot? :like, @review
            redirect_to product_path(@product), notice: "You can't like your own review"
        elsif @like.save
            redirect_to product_path(@product), notice: "Thanks for your like!"
        else
            redirect_to product_path(@product), notice: "Already liked"
        end
    end

    def destroy
        @review = Review.find params[:review_id]
        @like = current_user.likes.find params[:id]
        @product = Product.find params[:product_id]
        if cannot? :destroy, @like
            redirect_to product_path(@product), notice: "You can't remove a like you don't own"
        elsif @like.destroy
            redirect_to product_path(@product), notice: "Like removed"
        else
            redirect_to product_path(@product), notice: "Couldn't unlike the review"
        end
    end
end
