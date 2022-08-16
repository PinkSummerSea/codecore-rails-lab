require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "#new" do
        it "requires a render of a new template" do
            get(:new)
            expect(response).to render_template(:new)
        end

        it "requires setting an instance variable with a new news article" do
            get(:new)
            expect(assigns(:user)).to be_a_new(User)
        end
    end

    describe "#create" do
        context "with valid params" do
            def valid_request
                post(:create, params: {
                    user: FactoryBot.attributes_for(:user)
                })
            end        
        
            it "requires a new creation of a user in the db" do
                count_before = User.count  
                valid_request
                count_after = User.count 
                expect(count_after).to eq(count_before + 1) 
            end

            it "requires a redirect to the home page" do
                valid_request
                user = User.last
                expect(response).to redirect_to root_path
            end

            it "requires to sign the user in" do
                valid_request
                user = User.last
                expect(session[:user_id]).to eq(user.id)
            end
        end

        context "with invalid params" do
            def invalid_request
                post(:create, params: {
                    user: FactoryBot.attributes_for(:user, first_name: nil)
                })
            end

            it "requires the db does not save the new record of the news article" do
                count_before = User.count 
                invalid_request
                count_after = User.count
                expect(count_after).to eq(count_before)
            end

            it "requires no redirect but render the new page" do
                invalid_request
                expect(response).to render_template(:new)
            end
        end
    end
end 
