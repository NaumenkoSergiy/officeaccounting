module Money
  class ArticlesController < ApplicationController
    before_action :redirect_to_new_session
    before_action :set_article, only: [:destroy, :update, :show]
    before_action :define_article, only: :index
    before_action :all_articles, only: [:index, :create]

    def index
      respond_to do |format|
        format.js
        format.json { render json: articles_for_select2, status: 200 }
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

    def articles_for_select2
      Article.all.map do |article|
        { value: article.id, text: article.name }
      end
    end
  end
end
