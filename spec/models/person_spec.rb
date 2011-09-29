require 'spec_helper'

describe Person do

  subject {Factory.build("person")}

  it "requires a name" do
    subject.name = nil

    subject.should have(1).error_on("name")
  end

  it "requires a campaign" do
    subject.campaign = nil

    subject.should have(1).error_on("campaign")
  end

end
