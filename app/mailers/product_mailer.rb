class ProductMailer < ApplicationMailer
    def notify_product_owner(product)
        @product = product
        @owner = @product.user
        mail(to: @owner.email, subject: "Your product's details")
    end

    def review_notification(review)
        @review = review
        @product = @review.product 
        @owner = @product.user 
        mail(to: @owner.email, subject: "You got a new review!")
    end
end
