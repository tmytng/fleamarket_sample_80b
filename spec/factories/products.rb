FactoryBot.define do

    factory :product do
        name                {"歩毛シューズ"}
        price               {600}
        description         {"今冬の新作です"}
        condition           {"unused"}
        shipping_cost       {"shipping_fee_on_shipper"}
        shipping_days       {"days1_2"}
        prefecture          {"千葉県"}
        trading_status      {"sold"}
        # user_id             {1}
        size                {"大きい"}
        # category_id         {1}
        # brand_id            {1}
        association :user
        # category
        association :brand

    end
end

