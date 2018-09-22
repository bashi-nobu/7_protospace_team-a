class CategoryController < ApplicationController
  def index
    @categorys = Category.includes(:prototype_categories).page(params[:page])
  end

  def show
    categorys = Category.includes(:prototype_categories).find(params[:id])
    @prototypes = categorys.prototypes.page(params[:page])
    render 'prototypes/index'
  end
end
