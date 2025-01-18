class Order < ApplicationRecord
  has_many :order_products

  # Validations
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :customer_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :address, presence: true
  validates :fulfilled, inclusion: { in: [true, false], message: "must be true or false" }

  # Scopes and Class Methods
  scope :fulfilled_orders, -> { where(fulfilled: true).order(created_at: :asc) }
  scope :un_fulfilled_orders, -> { where(fulfilled: false).order(created_at: :asc) }
  scope :take_orders, -> { where(fulfilled: false).order(created_at: :desc).take(5) }
  scope :sales, -> { where(created_at: Time.now.midnight..Time.now).count }
  scope :revenue, -> { where(created_at: Time.now.midnight..Time.now).sum(:total).round }
  scope :avg_sale, -> { where(created_at: Time.now.midnight..Time.now).average(:total)&.round }
  scope :by_day, -> { where("created_at > ?", Time.now - 7.days).order(:created_at) }

  # Custom Methods
  def self.revenue_by_day
    orders_by_day = by_day.group_by { |order| order.created_at.to_date }
    orders_by_day.map { |day, orders| [day.strftime("%A"), orders.sum(&:total)] }
  end
end
