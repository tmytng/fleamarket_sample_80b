class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, length: { maximum: 15 }
  validates :family_name, presence: true, length: { maximum: 15 }
  validates :first_name, presence: true, length: { maximum: 15 }
  validates :family_name_kana, presence: true, length: { maximum: 15 }
  validates :first_name_kana, presence: true, length: { maximum: 15 }
  validates :birth_day, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true

  validates :nickname, presence: true, uniqueness: true
end
