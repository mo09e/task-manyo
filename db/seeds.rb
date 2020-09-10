10.times do |n|
  name = Faker::Artist.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: false
               )
end

User.create!(name: "AdminUser",
             email: "admin@example.com",
             password: 'password',
             password_confirmation: 'password',
             admin: true
             )

10.times do |n| labels_test = Label.create!([name: "Task#{n + 1}"]) end

10.times do |n|
  Task.create!(
    task_name: "No.#{n + 1} task",
    content: 'task_detail',
    deadline: '2020-09-05 00:00:00',
    status: '未着手',
    priority: 2,
    user_id:  User.first.id + 1
  )
end
