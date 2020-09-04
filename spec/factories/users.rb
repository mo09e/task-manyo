FactoryBot.define do
  factory :admin_user do
    name { "Michelangelo" }
    email { "pieta@sugoi.jp" }
    password { "virginmary" }
    admin { 'true' }
  end

  factory :user, class: User do
    name { "daVinchi" }
    email { "monalisa@sugoi.jp" }
    password { "leonardo" }
    admin { 'false' }
  end
end
