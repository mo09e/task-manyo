FactoryBot.define do
  factory :task do
    task_name { 'test_task_name' }
    content { 'test_content' }
  end
  factory :second_task, class: Task do
    task_name { 'Sample_task2' }
    content { 'take a work' }
  end
end
