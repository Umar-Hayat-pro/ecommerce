class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.take_orders

    # Quick stats links
    @quick_stats = {
      sales: Order.sales,
      revenue: Order.revenue,
      avg_sale: Order.avg_sale,
      per_sale: OrderProduct.per_sale,
    }

    # Grouping orders and calculating revenue by day
    @orders_by_day = Order.by_day.group_by { |order| order.created_at.to_date }
    @revenue_by_day = Order.revenue_by_day

    # Fill in missing days for the last 7 days
    if @revenue_by_day.count < 7
      days_of_week = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
      current_day = Date.today.strftime("%A")
      current_day_index = days_of_week.index(current_day)
      next_day_index = (current_day_index + 1) % days_of_week.length

      ordered_days_with_current_last = days_of_week[next_day_index..-1] + days_of_week[0...next_day_index]

      data_hash = @revenue_by_day.to_h
      complete_ordered_array_with_current_last = ordered_days_with_current_last.map do |day|
        [day, data_hash.fetch(day, 0)]
      end

      @revenue_by_day = complete_ordered_array_with_current_last
    end
  end
end
