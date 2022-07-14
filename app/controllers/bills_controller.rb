class BillsController < ApplicationController
    def new
        p params
        @amount = params[:amount].to_f
        @tax = params[:tax].to_f
        @tip = params[:tip].to_f
        @people = params[:people].to_i
        @result = @amount * (1 + @tax / 100 + @tip / 100) / @people
        p @result
        p @result.nan?
    end
    

end
