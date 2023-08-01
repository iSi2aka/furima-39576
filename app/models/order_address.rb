class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street_num, :building_num, :phone_num,
                :user_id, :item_id

  with_options presence: true do
    validates :postal_code,     format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)", allow_blank: true}
    validates :city,            format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "は（全角）で入力する必要があります", allow_blank: true	}  
    validates :street_num,      format: { with: /\A[ぁ-んァ-ヶ一-龥々ー0-9a-zA-Z^\-]+\z/, message: "は ハイフン（-）以外の記号は使用できません", allow_blank: true }
    validates :phone_num,       format: { with: /\A\d{1,11}\z/, message: "は（半角数字）最大11文字で入力する必要があります", allow_blank: true }
    validates :user_id
    validates :item_id
   
  end 
  validates :prefecture_id,   numericality: { other_than: 1, message: "can't be blank" }

  def save(user_id, item_id)
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, street_num: street_num, building_num: building_num, phone_num: phone_num, order_id: order.id)
  end
end

 