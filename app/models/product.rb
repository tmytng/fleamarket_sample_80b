class Product < ApplicationRecord

    has_many :product_imgs, dependent: :destroy
    belongs_to :category
    has_many :brands, dependent: :destroy
    belongs_to :user
    accepts_nested_attributes_for :product_imgs, limit: 10, allow_destroy: true
    accepts_nested_attributes_for :brands, allow_destroy: true

    validates :name, :price, :description, :condition, :size, :shipping_cost, :shipping_days, :prefecture, :user_id, :category_id, :product_imgs ,presence: true
    # validates :trading_status,  presence: true
    validates :name, length: { maximum: 40 }
    validates :description, length: {maximum: 1000}
    validates :price, numericality: { only_integer: true,greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
    validates :condition, :shipping_cost, :shipping_days, :prefecture, exclusion: { in: ["---"] }
    validates :category_id, presence: true, exclusion: { in: 1..158 }

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
    },_prefix: true

    enum prefecture:{
        '---':       0,
        hokkaido:    1,
        aomori:      2,
        iwate:       3,
        miyagi:      4,
        akita:       5,
        yamagata:    6,
        fukushima:   7,
        ibaraki:     8,
        tochigi:     9,
        gunma:      10,
        saitama:    11,
        chiba:      12,
        tokyo:      13,
        kanagawa:   14,
        niigata:    15,
        toyama:     16,
        ishikawa:   17,
        fukui:      18,
        yamanashi:  19,
        nagano:     20,
        gifu:       21,
        shizuoka:   22,
        aichi:      23,
        mie:        24,
        shiga:      25,
        kyoto:      26,
        osaka:      27,
        hyogo:      28,
        nara:       29,
        wakayama:   30,
        tottori:    31,
        shimane:    32,
        okayama:    33,
        hiroshima:  34,
        yamaguchi:  35,
        tokushima:  36,
        kagawa:     37,
        ehime:      38,
        kochi:      39,
        fukuoka:    40,
        saga:       41,
        nagasaki:   42,
        kumamoto:   43,
        oita:       44,
        miyazaki:   45,
        kagoshima:  46,
        okinawa:    47
  }

    def previous
      Product.where("id < ?", self.id).order("id DESC").first
    end

    def next
      Product.where("id > ?", self.id).order("id ASC").first
    end

  end

# for check
