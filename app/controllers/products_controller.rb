class ProductsController < ApplicationController
  def index
    @term = params[:search]
    query = Product.search(include: :categories) do
      with(:active, true)
      with(:is_deleted, false)
      fulltext params[:search] do
        boost_fields :title => 3.0
        boost_fields :description => 2.0
      end
      order_by :created_at, :desc
      paginate :cursor => params[:page].presence || '*', :per_page => 10
    end

    @products = query.results
    params[:page] = @products.next_page_cursor
  end
end
