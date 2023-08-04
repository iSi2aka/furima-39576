class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :fees_burden
  belongs_to :prefecture
  belongs_to :days_to_ship

  validates :image,           presence: true
  validates :title,           presence: true
  validates :description,     presence: true 
  validates :category_id,     numericality: { other_than: 1, message: "を入力してください" }
  validates :condition_id,    numericality: { other_than: 1, message: "を入力してください" }
  validates :fees_burden_id,  numericality: { other_than: 1, message: "を入力してください" }
  validates :prefecture_id,   numericality: { other_than: 1, message: "を入力してください" }
  validates :days_to_ship_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :price,           presence: true, 
                              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, allow_blank: true }

  belongs_to :user
  has_one_attached :image
  has_one :order
end
