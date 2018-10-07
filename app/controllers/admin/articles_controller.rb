class Admin::ArticlesController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Articles', :admin_articles_path

  def index
    @articles = Article.all
  end

  def edit
    @article = Article.find(params[:id])
    breadcrumb @article.title, edit_admin_article_path(@article)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.create!(article_params)
    redirect_to edit_admin_article_path(@article)
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to admin_articles_path
    else
      render 'edit'
    end
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def article_params
      params.require(:article).permit(:title, :image_id, :header, :body, :published, :homepage, {:tag_ids => []}, {images: []})
    end
end