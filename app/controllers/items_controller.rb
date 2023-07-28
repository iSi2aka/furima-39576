class ItemsController < ApplicationController
  def index
    @items = Item.order("created_at DESC")
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

  private

  def item_params
    params.rquire(:item).permit(:title, :description, :category_id, :condition_id, :fees_burden_id, :prefecture_id, :days_to_ship_id, :price )
  end

end
