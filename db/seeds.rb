# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create!(name: "Eric W",
                 email: "ericw@xmtp.net",
                 password: "password",
                 password_confirmation: "password")

c = u.campaigns.create!(name: "Rrkenlor")

p = c.people.create!(name: "Alzara",
                     description: "A powerful wizard.")

fixtures_dir = File.join(File.dirname(__FILE__), "../spec/fixtures")
photo = PersonUpload.new("caption" => "Awww, isn't he cute!?",
                         "upload" => File.open(File.join(fixtures_dir, "Asher.jpg")))
p.uploads << photo
pdf = PersonUpload.new("upload" => File.open(File.join(fixtures_dir, "Driving Techniques.pdf")))
p.uploads << pdf



