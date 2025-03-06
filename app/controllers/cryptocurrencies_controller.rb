class CryptocurrenciesController < ApplicationController
  def index
    @cryptocurrencies = Cryptocurrency.order(rank: :asc).page(params[:page]).per(20)
  end

  def show
    @cryptocurrency = Cryptocurrency.find(params[:id])
    @categories = @cryptocurrency.categories
  end
end
