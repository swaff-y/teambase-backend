User.delete_all
Project.delete_all
Task.delete_all

user_array = []
5.times do
  create = User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.email,
    department: "Teambase",
    password: "chicken",
    image_url: "http://www.fillmurray.com/100/100"
  )
  user_array.push create
end
puts "5 Users Created"
project_array = []
5.times do
  create = Project.create!(
    name: Faker::TvShows::GameOfThrones.character,
    due_date: Faker::Date.forward(days: 23),
    status: "In Progress",
    category: Faker::Games::Heroes.specialty,
    description: Faker::TvShows::GameOfThrones.quote
  )
  project_array.push create
end
puts "5 Projects Created"
task_array = []
15.times do
  create = Task.create!(
    name: Faker::TvShows::GameOfThrones.character,
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    due_date: Faker::Date.forward(days: 23),
    status: "In Progress",
    description: Faker::TvShows::GameOfThrones.quote
  )
  task_array.push create
end
puts "15 Tasks Created"

# p task_array
set1 = 0
set2 = 0
set3 = 0
15.times do |i|

  if i <= 4
    project_array[set1].tasks << task_array[i]
    set1 += 1
  elsif i > 4 && i <= 9
    project_array[set2].tasks << task_array[i]
    set2 += 1
  else
    project_array[set3].tasks << task_array[i]
    set3 += 1
  end
end

puts "Testing projects -< tasks associations:"
puts "The task '#{ Task.first.name }' is on project #{Task.first.project.name}"
puts "The project #{ Project.last.name } has task: #{ Project.last.tasks.pluck(:name).join(', ') }"

set1 = 0
set2 = 0
set3 = 0
15.times do |i|

  if i <= 4
    user_array[set1].tasks << task_array[i]
    set1 += 1
  elsif i > 4 && i <= 9
    user_array[set2].tasks << task_array[i]
    set2 += 1
  else
    user_array[set3].tasks << task_array[i]
    set3 += 1
  end
end

puts "Testing users >-< tasks associations:"
puts "The task '#{ Task.first.name }' has users #{Task.first.users.pluck(:name).join(',')}"
puts "The user #{ User.last.name } has tasks: #{ User.last.tasks.pluck(:name).join(', ') }"
