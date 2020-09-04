FactoryBot.define do
  factory :admin_user do
    id {1}
    name { "Michelangelo" }
    email { "pieta@sugoi.jp" }
    password { "virginmary" }
    password_digest { "virginmary" }
    admin { 'true' }
  end

  factory :user, class: User do
    id {2}
    name { "daVinchi" }
    email { "monalisa@sugoi.jp" }
    password { "leonardo" }
    password_digest { "leonardo" }
    admin { 'false' }
  end
end
