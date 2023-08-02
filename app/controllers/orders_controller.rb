class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = OrderAddress.new
  end
  
  def create
    @user = current_user
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item[:price],
        card: order_params[:token],
        currency: 'jpy'
      )
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
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_order
    @item = Item.find(params[:item_id])
    if (current_user.id == @item.user_id ) || @item.order.present?
      redirect_to root_path
    end
  end 
end