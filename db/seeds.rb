# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

flights = Flight.create([{ flight: 'GD2501',\
	                       schedule: "08:00",\
	                       from: 'Xi\'an' ,\
	                       to: 'Chengdu',\
	                       weekdays_reg_price: 1100 ,\
	                       weekdays_rew_price: 800 ,\
	                       weekends_reg_price: 900 ,\
	                       weekends_rew_price: 500 },\
	                       { flight: 'GD2502',\
	                       schedule: "12:00",\
	                       from: 'Chengdu' ,\
	                       to: 'Xi\'an',\
	                       weekdays_reg_price: 1700 ,\
	                       weekdays_rew_price: 900 ,\
	                       weekends_reg_price: 800 ,\
	                       weekends_rew_price: 900 },\
	                       { flight: 'GD2606',\
	                       schedule: "12:25",\
	                       from: 'Xi\'an' ,\
	                       to: 'Chengdu',\
	                       weekdays_reg_price: 1600 ,\
	                       weekdays_rew_price: 1100 ,\
	                       weekends_reg_price: 600 ,\
	                       weekends_rew_price: 500 },\
	                       { flight: 'GD2607',\
	                       schedule: "16:25",\
	                       from: 'Chengdu' ,\
	                       to: 'Xi\'an',\
	                       weekdays_reg_price: 1600 ,\
	                       weekdays_rew_price: 1100 ,\
	                       weekends_reg_price: 600 ,\
	                       weekends_rew_price: 500 },\
	                       { flight: 'GD8732',\
	                       schedule: "19:30",\
	                       from: 'Xi\'an' ,\
	                       to: 'Chengdu',\
	                       weekdays_reg_price: 2200 ,\
	                       weekdays_rew_price: 1000 ,\
	                       weekends_reg_price: 1500 ,\
	                       weekends_rew_price: 400 },\
	                       { flight: 'GD8733',\
	                       schedule: "23:30",\
	                       from: 'Chengdu' ,\
	                       to: 'Xi\'an',\
	                       weekdays_reg_price: 1600 ,\
	                       weekdays_rew_price: 1500 ,\
	                       weekends_reg_price: 1000 ,\
	                       weekends_rew_price: 400 }])