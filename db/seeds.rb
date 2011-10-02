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

admin = UserRole.create!(name: "admin")

u = User.create!(name: "Eric W",
                 email: "ericw@xmtp.net",
                 password: "password",
                 password_confirmation: "password")
u.role = admin
u.save!

gygax = User.create!(name: "Gary G",
                 email: "gygax@example.com",
                 password: "password",
                 password_confirmation: "password")

c = gygax.campaigns.create!(name: "Gygaxian Hell", private: true)
c = u.campaigns.create!(name: "Gates of Hell", private: true)
c = u.campaigns.create!(name: "Rrkenlor",
                        description: "Set in the city of the same name.")

25.times do
  p = rand(3) + 3
  c.people.create!(name: Faker::Name.name, description: lorem(p))
end

p = c.people.create!(name: "Alzara",
                     description: <<EOF
#{lorem(4)}

This is a link to a person: (Pe:Alzara)

This link is to a non-existent person named (Pe:Foo).

This link has [alt text](Pe:Alzara).

This link has a title (Pe:Alzara "Foo").
EOF
)

fixtures_dir = File.join(File.dirname(__FILE__), "../spec/fixtures")
photo = PersonUpload.new("caption" => "Awww, isn't he cute!\?",
                         "upload" => File.open(File.join(fixtures_dir, "Asher.jpg")))
p.uploads << photo
pdf = PersonUpload.new("upload" => File.open(File.join(fixtures_dir, "Driving Techniques.pdf")))
p.uploads << pdf

p = c.people.create!(name: "Turtledove", description: lorem)
p = c.people.create!(name: "Boris Mulorkan", description: lorem)
p = c.people.create!(name: "Tanya Filamina", description: lorem)
