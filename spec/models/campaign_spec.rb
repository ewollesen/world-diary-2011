require 'spec_helper'

describe Campaign do

  subject {Factory.build("campaign")}

  it "requires a name" do
    subject.name = nil

    subject.should have(1).error_on("name")
  end

  it "requires a DM" do
    subject.dm = nil

    subject.should have(1).error_on("dm")
  end

  it "requires that name be unique per DM" do
    original = Factory.create("campaign", dm: subject.dm)

    subject.should have(1).error_on("name")
  end

  it "destroys its people upon destruction" do
    Factory.create("person", campaign: subject)

    expect {subject.destroy}.to change(Person, :count).by(-1)
  end
end
