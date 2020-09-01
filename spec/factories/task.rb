FactoryBot.define do
  factory :task do
    task_name { 'sample_name' }
    content { 'test_content' }
    deadline { '2020-08-29 13:40:00' }
  end

  factory :second_task, class: Task do
    task_name { 'Sample_task2' }
    content { 'take a work' }
    deadline { '2020-08-30 13:40:00' }
  end

  factory :third_task, class: Task do
    task_name { 'Sample_task3' }
    content { 'Eat lunch' }
    deadline { '2021-08-31 15:00:00' }
  end
end
