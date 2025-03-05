class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @cryptocurrencies = @category.cryptocurrencies.order(rank: :asc)
  end
end
