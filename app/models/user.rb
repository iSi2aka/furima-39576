class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  ZENKAKU_REGEXP       = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  KATAKANA_REGEXP      = /\A[\p{katakana}\u{30fc}]+\z/.freeze

  validates :password,         format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数を両方含む必要があります', allow_blank: true }
  validates :nickname,         presence: true
  validates :last_name_em,     presence: true, format: { with: ZENKAKU_REGEXP, message: 'は（全角）で入力する必要があります', allow_blank: true }
  validates :first_name_em,    presence: true, format: { with: ZENKAKU_REGEXP, message: 'は（全角）で入力する必要があります', allow_blank: true }
  validates :last_name_kana,   presence: true, format: { with: KATAKANA_REGEXP, message: 'は（カタカナ）で入力する必要があります', allow_blank: true }
  validates :first_name_kana,  presence: true, format: { with: KATAKANA_REGEXP, message: 'は（カタカナ）で入力する必要があります', allow_blank: true }
  validates :birth_day,        presence: true

  has_many :items

end