class GamblersController < ApplicationController
  def index
    @gamblers = Gambler.all.order(join_date: :desc)
  end

  def show
    @gambler = Gambler.find(params[:id])
    @casino_tables = @gambler.casino_tables
  end
end
