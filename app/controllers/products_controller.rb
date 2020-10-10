class ProductsController < ApplicationController
  def index
    if params[:search].present?
      @term = params[:search]
      query = Product.search(include: :categories) do
        fulltext @term do
          boost_fields :title => 3.0
          boost_fields :description => 2.0
        end
        order_by :created_at, :desc
        paginate :cursor => params[:page].presence || '*', :per_page => 10
      end

      @products = query.results
      params[:page] = @products.next_page_cursor
      @is_search = true
    else
      @is_search = false
      @products = Product.includes(:categories).all
    end
  end
end
