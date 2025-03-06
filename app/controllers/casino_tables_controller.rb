class CasinoTablesController < ApplicationController
  def index
    @casino_tables = CasinoTable.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @casino_table = CasinoTable.find(params[:id])
    @gambler = @casino_table.gambler
    @bets = @casino_table.bets.order(bet_time: :desc)
    @cryptocurrencies = @casino_table.cryptocurrencies.distinct
  end
end
