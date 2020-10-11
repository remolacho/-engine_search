class ProductsController < ApplicationController
  def index
    @term = params[:search]
    query = engine_search
    products(query)
    group_categories(query)
    more_like
  end

  private

  def engine_search
    Product.search(include: :categories) do
      with(:active, true)
      with(:is_deleted, false)
      fulltext params[:search] do
        boost_fields :title => 3.0
        boost_fields :categories => 2.0
      end
      order_by :created_at, :desc
      facet :categories
      paginate :cursor => params[:page].presence || '*', :per_page => 10
    end
  end

  def group_categories(query)
    @categories = query.facet(:categories).rows.map do |facet|
      { name: facet.value, count: facet.count }
    end
  end

  def products(query)
    @products = query.results
  end

  def more_like
    return unless params[:product_id].present?
    prod = Product.find(params[:product_id])
    query = Sunspot.more_like_this(prod) do
      fields :title, :categories
      minimum_term_frequency 5
      with(:active, true)
      with(:is_deleted, false)
      paginate :cursor => params[:page].presence || '*', :per_page => 150
    end

    @more_like = query.results
  end
end
