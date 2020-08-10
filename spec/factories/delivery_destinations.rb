FactoryBot.define do

    factory :delivery_destination do
        family_name           {"穂毛山"}
        first_name            {"歩毛太郎"}
        family_name_kana      {"ホゲヤマ"}
        first_name_kana       {"ホゲタロウ"}
        post_code             {2790000}
        prefecture            {"千葉県"}
        city                  {"浦安市舞浜"}
        address               {"1−1−1"}
        phone_number          {"09012345678"}
        user
    end
end