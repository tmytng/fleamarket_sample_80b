class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
# ここから追記
  has_many :products dependent: :destroy
  has_one :delivery_destination dependent: :destroy
  has_one :credit_card dependent: :destroy

  validates :nickname, presence: true, uniqueness: true
end
