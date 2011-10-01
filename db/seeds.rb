# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def lorem(paragraphs=3)
  Faker::Lorem.paragraphs(paragraphs).join("\n\n")
end

u = User.create!(name: "Eric W",
                 email: "ericw@xmtp.net",
                 password: "password",
                 password_confirmation: "password")

c = u.campaigns.create!(name: "Rrkenlor")

25.times do
  c.people.create!(name: Faker::Name.name, description: lorem)
end

p = c.people.create!(name: "Alzara",
                     description: lorem(4))

fixtures_dir = File.join(File.dirname(__FILE__), "../spec/fixtures")
photo = PersonUpload.new("caption" => "Awww, isn't he cute!\?",
                         "upload" => File.open(File.join(fixtures_dir, "Asher.jpg")))
p.uploads << photo
pdf = PersonUpload.new("upload" => File.open(File.join(fixtures_dir, "Driving Techniques.pdf")))
p.uploads << pdf

p = c.people.create!(name: "Turtledove", description: lorem)
p = c.people.create!(name: "Boris Mulorkan", description: lorem)
p = c.people.create!(name: "Tanya Filamina", description: lorem)
