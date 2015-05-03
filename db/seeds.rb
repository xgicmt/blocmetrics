# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
User.destroy_all
RegisteredApplication.destroy_all
Event.destroy_all

5.times do  
	user = User.new(
		name:       Faker::Name.name,
		email:      Faker::Internet.email,
		password:   Faker::Lorem.characters(10)
		)
	user.skip_confirmation!
	user.save!
end
users = User.all

25.times do 
	registered_application = RegisteredApplication.create!(
		user:     users.sample,
		name:     Faker::App.name,
		url:      Faker::Internet.url 
		)
end
registered_applications = RegisteredApplication.all

eventOptions = ['Clicked on Event', 'Scroll Action Happened', 'Video was Watched', 'Shopping Cart was Emptied']

50.times do  
	event = Event.create!(
		registered_application: registered_applications.sample,
		eventname: eventOptions[rand(0..3)]
		)
end

admin = User.new(
	name:     'Chris Thompson',
	email:    'xgicmt@gmail.com',
	password: 'JakeandKate',
	)
admin.skip_confirmation!
admin.save!
puts "Seed Complete"
puts "#{User.count} users created "
puts "#{RegisteredApplication.count} Apps created!"
puts "#{Event.count} Events created"