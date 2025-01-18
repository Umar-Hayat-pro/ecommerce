class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def self.per_sale
    joins(:order)
      .where(orders: { created_at: Time.now.midnight..Time.now })
      &.average(:quantity)
  end
end
