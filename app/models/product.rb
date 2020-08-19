class Product < ApplicationRecord

    has_many :product_imgs , dependent: :destroy

    belongs_to :category
    has_many :brands

    belongs_to :user
    accepts_nested_attributes_for :product_imgs, limit: 10, allow_destroy: true
    accepts_nested_attributes_for :brands

    validates :name, :price, :description, :condition, :size, :shipping_cost, :shipping_days, :prefecture, :user_id,:category_id,  presence: true
    # validates :trading_status,  presence: true
    validates :name, length: { maximum: 40 }
    validates :description, length: {maximum: 1000}
    validates :price, numericality: { only_integr: true,greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

    enum condition:{
        '---':           0, #---
        unused:          1, #新品、未使用
        nearly_unused:   2, #未使用に近い
        not_injured:     3, #目立った傷や汚れなし
        bit_injured:     4, #やや傷や汚れあり
        injured:         5, #傷や汚れあり
        bad:             6,  #全体的に状態が悪い
    },_prefix: true

    enum shipping_cost:{
        '---':                      0,  #---
        shipping_fee_on_shipper:    1,  #送料込み（出品者負担）
        shipping_fee_on_receiver:   2,  #着払い（購入者負担）
    },_prefix: true

    enum shipping_days:{
        '---':      0,  #---
        days1_2:    1,  #
        days2_3:    2,  #2日~3日で発送
        days4_7:    3,  #4日~7日で発送
    }
end
