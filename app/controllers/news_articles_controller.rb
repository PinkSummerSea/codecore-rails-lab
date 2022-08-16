class NewsArticlesController < ApplicationController

    before_action :find_news_article, except: [:index, :new, :create]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def new
        @news_article = NewsArticle.new
    end

    def create
        @news_article = NewsArticle.new(news_article_params)
        @news_article.user = current_user
        if @news_article.save
            redirect_to news_article_path(@news_article)
        else  
            render :new
        end
    end

    def show
    end

    def index
       @news_articles = NewsArticle.order(created_at: :desc)
    end

    def destroy
        if can?(:crud, @news_article)
            @news_article.destroy
            flash[:danger] = "Deleted news article"
            redirect_to news_articles_path
        else
            flash[:danger] = "Not Authorized"
            redirect_to root_path
        end
    end

    def edit
        if can?(:crud, @news_article)
            render :edit
        else
            flash[:danger] = "Not Authorized"
            redirect_to root_path
        end
    end

    def update
        if can?(:crud, @news_article)
            @news_article.update news_article_params
            if @news_article.save
                redirect_to news_article_path(@news_article)
            else
                render :edit
            end
        else
            flash[:danger] = "Not Authorized"
            redirect_to root_path
        end
    end

    private

    def find_news_article
        @news_article = NewsArticle.find params[:id]
    end

    def news_article_params
        params.require(:news_article).permit!
    end
end
