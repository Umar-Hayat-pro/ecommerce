class Product < ApplicationRecord
  has_many_attached :images do |attach|
    attach.variant :thumb, resize_to_limit: [50, 50]
    attach.variant :medium, resize_to_limit: [250, 250]
  end
  belongs_to :category
  has_many :stocks
  has_many :order_products
end
