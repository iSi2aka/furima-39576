class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update ]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end 
  end

  def show
  end

  def edit
    unless current_user.id == @item.user_id 
      redirect_to root_path
    end  
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    unless current_user.id == item.user_id 
      redirect_to root_path
    else
      item.destroy
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item)
          .permit(:image, :title, :description, :category_id, :condition_id, :fees_burden_id, :prefecture_id, :days_to_ship_id, :price )
          .merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
