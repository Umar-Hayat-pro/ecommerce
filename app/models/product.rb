class Product < ApplicationRecord
  has_many_attached :images do |attach|
    attach.variant :thumb, resize_to_limit: [50, 50]
  end
  belongs_to :category
end
