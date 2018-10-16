class Admin::TagsController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Tags', :admin_tags_path

  def index
    @tags = Tag.all
  end

  def edit
    @tag = Tag.find(params[:id])
    breadcrumb @tag.name, edit_admin_tag_path(@tag)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to edit_admin_tag_path(@tag)
    else
      render 'new'
    end
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admin_tags_path
    else
      render 'edit'
    end
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def tag_params
      params.require(:tag).permit(:name)
    end
end