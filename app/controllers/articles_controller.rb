class ArticlesController < ApplicationController

  breadcrumb 'Articles', :articles_path

  def show
    @article = Article.find(params[:id])
    breadcrumb @article.title, article_path(@article)
  end
  def index
    @articles = Article.all.order(created_at: :desc).page(params[:page]).per(25)
  end

end