class Product < ApplicationRecord
  has_many :category_products
  has_many :categories, through: :category_products

  searchable do
    text :title, :description
    text :categories do
      categories.map { |category| category.name }
    end

    time :created_at
    #  integer :category_ids, :multiple => true
  end
end
