class Order < ApplicationRecord
  def self.fulfilled_orders
    where(fulfilled: true).order(created_at: :asc)
  end

  def self.un_fulfilled_orders
    where(fulfilled: false).order(created_at: :asc)
  end
end
