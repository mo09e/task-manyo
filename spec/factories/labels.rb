FactoryBot.define do
  factory :label do
    name { "work" }
  end

  factory :second_label, class: Label do
    name { "etc" }
  end
end
