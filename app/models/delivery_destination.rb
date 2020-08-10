class DeliveryDestination < ApplicationRecord
  belongs_to :user

  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/

  validates :user_id, presence: true
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :post_code, presence: true, length: {maximum: 7}
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, format: { with: VALID_PHONE_REGEX, message: 'は有効でありません。'}
  
end
