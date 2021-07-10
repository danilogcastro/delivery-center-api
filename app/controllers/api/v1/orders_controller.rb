
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
                                      payments: {except: [:id, :order_id, :created_at, :updated_at]}
                                    },
                                      except: [:id, :customer_id, :created_at, :updated_at ], status: 200
    else
      render json: {error: "Order not found"}
    end
  end

  def create
    @order = Order.new(order_params)
    # @order.build_customer
    # @order.items.build
    # @order.payments.build
    if @order.save
      render json: @order, include: { customer: {except: [:id, :created_at, :updated_at ]},
                                      items: {except: [:id, :created_at, :updated_at]},
                                      payments: {except: [:id, :created_at, :updated_at]}
                                    },
                                      except: [:id, :customer_id, :created_at, :updated_at ], status: 200
    else
      render json: {error: "Error creating order"}
    end
  end

  private

  def order_params
    params.require(:order).permit(:external_code, 
                                  :store_id, 
                                  :sub_total,
                                  :delivery_fee,
                                  :total_shipping,
                                  :total,
                                  :country,
                                  :state,
                                  :city,
                                  :district,
                                  :street,
                                  :complement,
                                  :latitude,
                                  :longitude,
                                  :dt_order_create,
                                  :postal_code,
                                  :number,
                                  customer_attributes: [ :external_code, :name, :email, :contact ],
                                  items_attributes: [  :external_code, :name, :price, :quantity, :total],
                                  payments_attributes: [ :kind, :value]
                                )
  end
end
