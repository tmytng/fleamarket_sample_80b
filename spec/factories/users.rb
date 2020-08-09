FactoryBot.define do

  factory :user do
    nickname              {"kyota"}
    email                 {"kkk@gmail.com"}
    password              {"12345678"}
    password_confirmation {"12345678"}
    user_image            {"#"}
    profile               {"123"}
    family_name           {"金島"}
    first_name            {"鏡太"}
    family_name_kana      {"カネシマ"}
    first_name_kana       {"キョウタ"}
    birth_day             {"2020-08-08"}
  end

end