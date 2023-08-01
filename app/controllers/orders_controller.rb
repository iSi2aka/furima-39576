class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_order, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end
  
  def create
    @user = current_user
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save(@user.id, @item.id)
      redirect_to root_path
    else 
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address)
          .permit(:postal_code, :prefecture_id, :city, :street_num, :building_num, :phone_num)
          .merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_order
    @item = Item.find(params[:item_id])
  end 
end