class SearchController < ApplicationController
  def index
    @query = params[:q]
    @category_id = params[:category]
    @categories = Category.all.order(:name)
    
    if @query.present?
      # Start with a base query
      @cryptocurrencies = Cryptocurrency.order(rank: :asc)
      
      # Filter by category if provided
      if @category_id.present?
        @category = Category.find_by(id: @category_id)
        if @category
          @cryptocurrencies = @cryptocurrencies.joins(:categories).where(categories: { id: @category_id })
        end
      end
      
      # Apply text search
      @cryptocurrencies = @cryptocurrencies.where(
        "name ILIKE ? OR symbol ILIKE ? OR description ILIKE ?", 
        "%#{@query}%", "%#{@query}%", "%#{@query}%"
      )
    else
      @cryptocurrencies = []
    end
  end
end