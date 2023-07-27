class Item < ApplicationRecord
  validates :title,           presence: true
  validates :description,     presence: true 
  validates :category_id,     presence: true
  validates :condition_id,    presence: true
  validates :fees_burden_id,  presence: true
  validates :prefecture_id,   presence: true
  validates :days_to_ship_id, presence: true
  validates :price,           presence: true

  belongs_to :user
  has_one_attached :image

end
