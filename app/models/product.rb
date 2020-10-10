class Product < ApplicationRecord
  has_many :category_products, dependent: :delete_all
  has_many :categories, through: :category_products

  searchable auto_index: false do
    text :title, :description
    text :categories do
      categories.map { |category| category.name }
    end
    boolean :active
    boolean :is_deleted
    time :created_at
  end

  after_create :reindex_products
  after_update :reindex_products

  def reindex_products
    index!
  end
end
