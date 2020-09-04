FactoryBot.define do
  factory :task do
    user
    task_name { 'sample_name' }
    content { 'test_content' }
    deadline { '2020-08-29 13:40:00' }
    status { '完了' }
    priority { '低' }
  end

  factory :second_task, class: Task do
    user
    task_name { 'in the morning' }
    content { 'take a work' }
    deadline { '2020-08-30 13:40:00' }
    status { '着手中' }
    priority { '高' }
  end

  factory :third_task, class: Task do
    user
    task_name { 'at noon' }
    content { 'Eat lunch' }
    deadline { '2021-08-31 15:00:00' }
    status { '未着手' }
    priority { '中' }
  end
end
