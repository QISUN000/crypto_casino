class CryptocurrenciesController < ApplicationController
  def index
    @cryptocurrencies = Cryptocurrency.all.order(rank: :asc)
  end

  def show
    @cryptocurrency = Cryptocurrency.find(params[:id])
    @categories = @cryptocurrency.categories
  end
end
