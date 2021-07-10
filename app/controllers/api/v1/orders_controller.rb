class Api::V1::OrdersController < ApplicationController
  def index
    @orders = Order.all
    render json: @orders, status: 200
  end

  def show
    @order = Order.find(params[:id])
    if @order
      render json: @order, include: { customer: {except: [:id, :created_at, :updated_at ]},
                                      items: {except: [:id, :created_at, :updated_at]},
                                      payments: {except: [:id, :created_at, :updated_at]}
                                    },
                                      except: [:id, :customer_id, :created_at, :updated_at ], status: 200
    else
      render json: {error: "Order not found"}
    end
  end

  def create
  end

  private

  def order_params
  end
end
