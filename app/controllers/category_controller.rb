class CategoryController < ApplicationController
  def index
    @categorys = Category.includes(:prototype_categories).all
  end

  def show
    categorys = Category.includes(:prototype_categories).find(params[:id])
    @prototypes = categorys.prototypes
    render 'prototypes/index'
  end
end
