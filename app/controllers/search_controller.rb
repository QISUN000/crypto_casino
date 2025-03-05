class SearchController < ApplicationController
  def index
    @query = params[:q]
    
    if @query.present?
      @cryptocurrencies = Cryptocurrency.where("name ILIKE ? OR symbol ILIKE ? OR description ILIKE ?", 
                                            "%#{@query}%", "%#{@query}%", "%#{@query}%")
                                     .order(rank: :asc)
      
  
    else
      @cryptocurrencies = []
    end
  end
end
