class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
# # ここから追記
#   has_many :products, dependent: :destroy
  has_one :delivery_destination, dependent: :destroy
#   has_one :credit_card, dependent: :destroy

# バリデーションの追加
  validates :nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :birth_day, :password, :password_confirmation, :email, presence: true
  validates :nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, length: { maximum: 15 }
end
