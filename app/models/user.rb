class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
# # ここから追記
#   has_many :products, dependent: :destroy
#   has_one :delivery_destination, dependent: :destroy
#   has_one :credit_card, dependent: :destroy

  validates :nickname, presence: true, length: { maximum: 15 }
  validates :family_name, presence: true, length: { maximum: 15 }
  validates :first_name, presence: true, length: { maximum: 15 }
  validates :family_name_kana, presence: true, length: { maximum: 15 }
  validates :first_name_kana, presence: true, length: { maximum: 15 }
  validates :birth_day, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true
end
