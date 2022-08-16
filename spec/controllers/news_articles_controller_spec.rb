require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do
    describe "#new" do

        context "with signed in user" do
            before do
                session[:user_id] = FactoryBot.create(:user).id
            end
            it "requires a render of a new template" do
                get(:new)
                expect(response).to render_template(:new)
            end
    
            it "requires setting an instance variable with a new news article" do
                get(:new)
                expect(assigns(:news_article)).to be_a_new(NewsArticle)
            end
        end

        context "without signed in user" do
            it "requires redirect to sign in page" do
                get(:new)
                expect(response).to redirect_to new_session_path
            end
        end
    end

    describe "#create" do
        def valid_request
            post(:create, params: {
                news_article: FactoryBot.attributes_for(:news_article)
            })
        end
        context "with signed in user" do
            before do
                session[:user_id] = FactoryBot.create(:user).id
            end
            
            context "with valid params" do
                
    
                it "requires a new creation of a news article in the db" do
                    count_before = NewsArticle.count  
                    valid_request
                    count_after = NewsArticle.count 
                    expect(count_after).to eq(count_before + 1) 
                end
    
                it "requires a redirect to the show page for the new job post" do
                    valid_request
                    news_article = NewsArticle.last
                    expect(response).to redirect_to news_article_path(news_article)
                end
            end
    
            context "with invalid params" do
                def invalid_request
                    post(:create, params: {
                        news_article: FactoryBot.attributes_for(:news_article, title: nil)
                    })
                end
    
                it "requires the db does not save the new record of the news article" do
                    count_before = NewsArticle.count 
                    invalid_request
                    count_after = NewsArticle.count
                    expect(count_after).to eq(count_before)
                end
    
                it "requires no redirect but render the new page" do
                    invalid_request
                    expect(response).to render_template(:new)
                end
            end
        end

        context "without signed in user" do

            it "requires redirect to sign in page" do
                valid_request
                expect(response).to redirect_to new_session_path
            end
        end
        
    end

    describe "#show" do
        it "requires a render of the show template" do
            news_article = FactoryBot.create(:news_article)
            get(:show, params: {id: news_article.id})
            expect(response).to render_template(:show)
        end

        it "requires setting an instance variable @news_article for the show object" do
            news_article = FactoryBot.create(:news_article)
            get(:show, params: {id: news_article.id})
            expect(assigns(:news_article)).to eq(news_article)
        end
    end

    describe "#index" do
        it "requires a render of the index template" do
            get(:index)
            expect(response).to render_template(:index)
        end

        it "requires assigning an instance variable @news_articles which contains all the news articles in the db" do
            news_article1 = FactoryBot.create(:news_article)
            news_article2 = FactoryBot.create(:news_article)
            news_article3 = FactoryBot.create(:news_article)

            get(:index)

            expect(assigns(:news_articles)).to eq([news_article3, news_article2, news_article1])
        end
    end

    describe "#destroy" do
        context "with a signed in user" do
            context "as owner" do
                before do
                    owner_user = FactoryBot.create(:user)
                    session[:user_id] = owner_user.id
                    @news_article = FactoryBot.create(:news_article, user: owner_user)
                    delete(:destroy, params: {id: @news_article.id})
                end

                it "requires a record of news article to be removed from the db" do
                    expect(NewsArticle.find_by(id: @news_article.id)).to be(nil)
                end
        
                it "requires a redirect to the news articles index page" do
                    expect(response).to redirect_to(news_articles_path)
                end
        
                it "requires a flash message" do
                    expect(flash[:danger]).to be
                end

            end

            context "not owner" do
                it "requires a redirect to root path" do
                    session[:user_id] = FactoryBot.create(:user).id
                    @news_article = FactoryBot.create(:news_article)
                    delete(:destroy, params: {id: @news_article.id})
                    expect(response).to redirect_to root_path
                end

                it "requires a flash message" do
                    session[:user_id] = FactoryBot.create(:user).id
                    @news_article = FactoryBot.create(:news_article)
                    delete(:destroy, params: {id: @news_article.id})
                    expect(flash[:danger]).to be
                end
            end
        end

        context "without a signed in user" do
            it "requires a redirect to sign in page" do
                @news_article = FactoryBot.create(:news_article)
                delete(:destroy, params: {id: @news_article.id})
                expect(response).to redirect_to new_session_path
            end
        end
   
    end

    describe "#edit" do
        context "with a signed in user" do
            context "as owner" do
                before do
                    owner_user = FactoryBot.create(:user)
                    session[:user_id] = owner_user.id
                    @news_article = FactoryBot.create(:news_article, user: owner_user)
                end

                it "requires to render the edit template" do
                    get(:edit, params: {id: @news_article.id})
                    expect(response).to render_template(:edit)
                end
            end

            context "not owner" do
                before do
                    session[:user_id] = FactoryBot.create(:user).id
                    @news_article = FactoryBot.create(:news_article)
                end

                it "requires to redirect to root path" do
                    get(:edit, params: {id: @news_article.id})
                    expect(response).to redirect_to root_path
                end
            end
        end

        context "without a signed in user" do
            it "requires to redirect to sign in page" do
                @news_article = FactoryBot.create(:news_article)
                get(:edit, params: {id: @news_article.id})
                expect(response).to redirect_to new_session_path
            end
        end
    end

    describe "#update" do

        context "with signed in user" do
            context "as owner" do
                before do
                    owner_user = FactoryBot.create(:user)
                    session[:user_id] = owner_user.id
                    @news_article = FactoryBot.create(:news_article, user: owner_user)
                end

                context "with valid params" do
                    it "requires the record to be update with the new params" do
                        
                        new_title = "An Edited Title"
        
                        patch(:update, params: {id: @news_article.id, news_article: {title: new_title}})
        
                        expect(@news_article.reload.title).to eq(new_title)
                    end
        
                    it "requires a redirect to the news article's shwo page" do
                        
                        new_title = "an edited title"
                        patch(:update,params: {id: @news_article.id, news_article: {title: new_title}})
        
                        expect(response).to redirect_to(news_article_path(@news_article))
        
                    end
                end
        
                context "with invalid params" do
                    it "requires the news article to not be updated in the db" do
                       
                        old_title = @news_article.title
                        new_title = nil
                        patch(:update,params: {id: @news_article.id, news_article: {title: new_title}})
                        expect(@news_article.reload.title).to eq(old_title)
                    end
                end
            end

            context "not owner" do
                before do
                    session[:user_id] = FactoryBot.create(:user).id
                    @news_article = FactoryBot.create(:news_article)
                end

                it "requires redirect to the root path" do
                    new_title = "an edited title"
                    patch(:update,params: {id: @news_article.id, news_article: {title: new_title}})
                    expect(response).to redirect_to root_path
                end
            end
        end

        context "without signed in user" do
            it "requires redirect to the root path" do
                news_article = FactoryBot.create(:news_article)
                new_title = "an edited title"
                patch(:update,params: {id: news_article.id, news_article: {title: new_title}})
                expect(response).to redirect_to new_session_path
            end
        end


        
    end
end
