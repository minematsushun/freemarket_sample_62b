FactoryBot.define do
  factory :user do

    nickname                   {"abe"}
    email                      {"kkk@gmail.com"}
    password                   {"000000"}
    first_name                 {"メルカリ"}
    last_name                  {"太朗"}
    first_name_kana            {"メルカリ"}
    last_name_kana             {"タロウ"}
    birthday_year              {"2010"}
    birthday_month             {"12"}
    birthday_day               {"12"}
    phone_number               {"090-1234-5678"}
    address_first_name         {"メルカリ"}
    address_last_name          {"太朗"}
    address_first_name_kana    {"メルカリ"}
    address_last_name_kana     {"タロウ"}
    post_code                  {"123-4567"}
    address_prefecture         {"大阪府"}
    address_city               {"大阪市北区"}
    address_number             {"1234"}
  end
end
