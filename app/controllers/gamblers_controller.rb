class GamblersController < ApplicationController
  def index
    @gamblers = Gambler.all.order(join_date: :desc).page(params[:page]).per(12)
  end

  def show
    @gambler = Gambler.find(params[:id])
    @casino_tables = @gambler.casino_tables
  end
end
