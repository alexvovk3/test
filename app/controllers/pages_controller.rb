# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :set_page, only: %i[show new edit update]

  def index
    @pages = Page.all.arrange
  end

  def show; end

  def new_root
    @page_new = Page.new
    render :new
  end

  def new
    @page_new = Page.new(parent: @page)
  end

  def create
    @page_new = Page.new(page_params_create)

    if @page_new.save
      redirect_to page_show_path(@page_new.full_path), notice: 'Страница создана'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @page.update(page_params_update)
      redirect_to page_show_path(@page.full_path), notice: 'Страница обновлена'
    else
      render :edit
    end
  end

  private

  def set_page
    names = params[:path].split('/')
    @page = Page.find_by!(name: names.last)

    # check correct path
    raise ActionController::RoutingError, 'Not Found' if @page.full_path != params[:path]
  end

  def page_params_create
    params.require(:page).permit(:name, :title, :content, :parent_id)
  end

  def page_params_update
    params.require(:page).permit(:title, :content)
  end
end
