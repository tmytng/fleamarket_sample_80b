FactoryBot.define do

    factory :product do
        id                  {1}
        name                {"歩毛シューズ"}
        price               {600}
        description         {"今冬の新作です"}
        condition           {"unused"}
        shipping_cost       {"shipping_fee_on_shipper"}
        shipping_days       {"days1_2"}
        prefecture          {1}
        trading_status      {0}
        size                {"28cm"}
        user
        category
    end
end

# has_many :product_imgs , dependent: :destroy
# belongs_to :category
# has_many :brands
# belongs_to :user
# accepts_nested_attributes_for :product_imgs, limit: 10, allow_destroy: true
# accepts_nested_attributes_for :brands