# 5.times do |n|
#   name = Faker::Artist.name
#   email = Faker::Internet.email
#   password = "password"
#   User.create!(name: name,
#                email: email,
#                password: password,
#                password_confirmation: password,
#                admin: false
#                )
# end

# User.create!(name: "AdminUser",
#              email: "admin@example.com",
#              password: 'password',
#              password_confirmation: 'password',
#              admin: true
#              )

# 10.times do |n|
#   User.create!(name: "SampleUser#{n}",
#                email: "test_sample#{n}@example.jp",
#                password: '000word123',
#                password_confirmation: '000word123',
#                admin: false
#                )
# end

10.times do |n| labels_test = Label.create!([name: "Task#{n + 1}"]) end

10.times do |n|
  Task.create!(
    task_name: "No.#{n + 1} task",
    content: 'task_detail',
    deadline: '2020-09-05 00:00:00',
    status: '未着手',
    priority: 2,
    user_id:  26
  )
end
10.times do |n|
  Task.create!(
    task_name: "No.#{n + 1} task",
    content: 'task_detail',
    deadline: '2020-09-06 00:00:00',
    status: '完了',
    priority: 1,
    user_id:  27
  )
end
10.times do |n|
  Task.create!(
    task_name: "No.#{n + 1} task",
    content: 'task_detail',
    deadline: '2020-09-05 00:00:00',
    status: '未着手',
    priority: 0,
    user_id:  28
  )
end
10.times do |n|
  Task.create!(
    task_name: "No.#{n + 1} task",
    content: 'task_detail',
    deadline: '2020-09-06 00:00:00',
    status: '完了',
    priority: 1,
    user_id:  29
  )
end
10.times do |n|
  Task.create!(
    task_name: "No.#{n + 1} task",
    content: 'task_detail',
    deadline: '2020-09-05 00:00:00',
    status: '未着手',
    priority: 2,
    user_id:  30
  )
end
10.times do |n|
  Task.create!(
    task_name: "No.#{n + 1} task",
    content: 'task_detail',
    deadline: '2020-09-06 00:00:00',
    status: '完了',
    priority: 0,
    user_id:  31
  )
end
10.times do |n|
  Task.create!(
    task_name: "No.#{n + 1} task",
    content: 'task_detail',
    deadline: '2020-09-05 00:00:00',
    status: '未着手',
    priority: 2,
    user_id:  32
  )
end
10.times do |n|
  Task.create!(
    task_name: "No.#{n + 1} task",
    content: 'task_detail',
    deadline: '2020-09-06 00:00:00',
    status: '着手中',
    priority: 1,
    user_id:  33
  )
end
10.times do |n|
  Task.create!(
    task_name: "No.#{n + 1} task",
    content: 'task_detail',
    deadline: '2020-09-05 00:00:00',
    status: '未着手',
    priority: 2,
    user_id:  34
  )
end
10.times do |n|
  Task.create!(
    task_name: "No.#{n + 1} task",
    content: 'task_detail',
    deadline: '2020-09-06 00:00:00',
    status: '着手中',
    priority: 0,
    user_id:  35
  )
end
10.times do |n|
  Task.create!(
    task_name: "No.#{n + 1} task",
    content: 'task_detail',
    deadline: '2020-09-06 00:00:00',
    status: '着手中',
    priority: 0,
    user_id:  36
  )
end
