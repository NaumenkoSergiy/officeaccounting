module Money
  class ArticlesController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :set_article, only: [:destroy, :update, :show]
    before_action :define_article, only: :index
    before_action :all_articles, only: [:index, :create]
    
    def index
      if params[:page]
        acticles = Article.all
        render json: acticles, status: 200
      else
        respond_to do |format|
          format.js
        end
      end
    end

    def show
      respond_to do |format|
        format.js
      end
    end

    def create
      @article = Article.new article_params
      flash[:error] = t('validation.errors.invalid_data') unless @article.save
      respond_to do |format|
        format.js
      end
    end

    def update
      respond_to do |format|
        if @article.update(article_params)
          format.json { head :no_content }
        else
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @article.destroy
      respond_to do |format|
        format.js
      end
    end

    private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:code, :name)
    end

    def define_article
      @article ||= Article.new
    end

    def all_articles
      @articles = Article.all
    end
  end
end
