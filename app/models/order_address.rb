class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street_num, :building_num, :phone_num,
                :user_id, :item_id, :token

  with_options presence: true do
    validates :token
    validates :postal_code,     format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "はハイフン(‐)を正しい位置に含む必要があります", allow_blank: true}
  end 
    validates :prefecture_id,   numericality: { other_than: 1, message: "を入力してください" }
    
  with_options presence: true do
    validates :city  
    validates :street_num
    validates :phone_num,       format: { with: /\A\d{10,11}\z/, message: "は（半角数字）10~11文字で入力する必要があります", allow_blank: true}
    validates :user_id
    validates :item_id
  end 

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, street_num: street_num, building_num: building_num, phone_num: phone_num, order_id: order.id)
  end

end

 