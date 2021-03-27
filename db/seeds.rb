User.destroy_all
Project.destroy_all
Task.destroy_all
TaskCategory.destroy_all

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
    description: Faker::TvShows::GameOfThrones.quote,
    progress: rand(1..100)
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
    description: Faker::TvShows::GameOfThrones.quote,
    progress: rand(1..100)
  )
  task_array.push create
end
puts "15 Tasks Created"

task_category_array = []
5.times do
  create = TaskCategory.create!(
    name: Faker::Beer.brand
  )
  task_category_array.push(create)
end
puts "5 Task categories Created"

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
    task_array[i].users << user_array[0] << user_array[1] << user_array[2]
  elsif i > 4 && i <= 9
    task_array[i].users << user_array[2] << user_array[3] << user_array[4]
  else
    task_array[i].users << user_array[4] << user_array[0] << user_array[2]
  end
end

puts "Testing users >-< tasks associations:"
puts "The task '#{ Task.first.name }' has users #{Task.first.users.pluck(:name).join(',')}"
puts "The user #{ User.last.name } has tasks: #{ User.last.tasks.pluck(:name).join(', ') }"

5.times do |i|

    user_array[i].projects << project_array[0] << project_array[1] << project_array[2] << project_array[3] << project_array[4]

end

puts "Testing users >-< project associations:"
puts "The project '#{ Project.first.name }' has users #{Project.first.users.pluck(:name).join(',')}"
puts "The user #{ User.last.name } has projects: #{ User.last.projects.pluck(:name).join(', ') }"

set1 = 0
set2 = 0
set3 = 0
15.times do |i|

  if i <= 4
    task_category_array[set1].tasks << task_array[i]
    set1 += 1
  elsif i > 4 && i <= 9
    task_category_array[set2].tasks << task_array[i]
    set2 += 1
  else
    task_category_array[set3].tasks << task_array[i]
    set3 += 1
  end
end

puts "Testing task -< task_category:"
puts "The task '#{ Task.first.name }' has category #{Task.first.task_category.name}"
puts "The category #{ TaskCategory.last.name } has task: #{ TaskCategory.last.tasks.pluck(:name).join(', ') }"
