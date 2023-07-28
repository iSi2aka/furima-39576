class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end 
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :description, :category_id, :condition_id, :fees_burden_id, :prefecture_id, :days_to_ship_id, :price )
  end

end
