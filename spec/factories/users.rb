FactoryBot.define do
  factory :user do
    name { "daVinchi" }
    email { "monalisa@sugoi.jp" }
    password { "leonardo" }
    admin { 'true' }
  end

  factory :second_user , class: User do
    name { "Michelangelo" }
    email { "pieta@sugoi.jp" }
    password { "virginmary" }
    admin { 'false' }
  end
end
