# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Template.create(name: "standard-english")
Template.create(name: "standard-german")
Template.create(name: "standard-english-only-ITLOGO")

Author.create(
	name: "Christiane Hultsch",
	title: "Marketing Manager",
	phone: "+49-341-392993430",
	email: "pr@adytonsystems.com",
	image_url: "http://www.adytonsystems.com/newsletter/img/contact-hultsch.jpg"
	)

Author.create(
	name: "Romy Wuttke",
	title: "Marketing Assistant",
	phone: "+49-341-392993430",
	email: "pr@adytonsystems.com",
	image_url: "http://www.adytonsystems.com/newsletter/img/contact-wuttke.jpg"
	)

Author.create(
	name: "Ralph Skoruppa",
	title: "Head of Sales",
	phone: "+49-341-392993430",
	email: "sales@adytonsystems.com",
	image_url: "http://www.adytonsystems.com/newsletter/img/contact-skoruppa.jpg"
	)